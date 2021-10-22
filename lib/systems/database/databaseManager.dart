import 'dart:async';
import 'dart:developer';

import 'package:Kalories/systems/dataTypes/day.dart';
import 'package:Kalories/systems/dataTypes/ingredient.dart';
import 'package:Kalories/systems/dataTypes/dish.dart';
import 'package:Kalories/systems/dataTypes/nutritionalValues.dart';
import 'package:Kalories/systems/dataTypes/settings.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static const _databaseFileName = 'kalories_test.db';

  static const _ingredientsDatabaseName = 'ingredients';
  static const _mealsDatabaseName = 'meals';
  static const _daysDatabaseName = 'days';
  static const _settingsDatabaseName = 'settings';
  static const _ingredientsInMealsDatabaseName = 'ingredients_in_meals';
  static const _firstMealInDayDatabaseName = 'meal_in_day_1';
  static const _secondMealInDayDatabaseName = 'meal_in_day_2';
  static const _thirdMealInDayDatabaseName = 'meal_in_day_3';

  static Database _database;

  static int currentlyEditedMealList = 0;
  static int currentlyEditedDay;

  static initializeDatabase() async {
    currentlyEditedDay = Day.getIdFor(DateTime.now());
    _database = await openDatabase(_databaseFileName, version: 1, onCreate: _onCreate, onOpen: _getSettings);
  }

  static _onCreate(Database db, int ver) async {
    var batch = db.batch();

    batch.execute('''CREATE TABLE IF NOT EXISTS  $_settingsDatabaseName (
          id INTEGER PRIMARY KEY,
          caloriesTarget REAL NOT NULL,
          carbohydrateTarget REAL NOT NULL,
          fatsTarget REAL NOT NULL,
          proteinsTarget REAL NOT NULL
        )''');

    batch.execute('''CREATE TABLE IF NOT EXISTS $_ingredientsDatabaseName (
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL,
          unit TEXT NOT NULL,
          calories REAL NOT NULL,
          carbohydrates REAL NOT NULL,
          fats REAL NOT NULL,
          proteins REAL NOT NULL
        )''');

    batch.execute('''CREATE TABLE IF NOT EXISTS $_mealsDatabaseName (
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL,
          unit TEXT NOT NULL
        )''');

    batch.execute('''CREATE TABLE IF NOT EXISTS $_ingredientsInMealsDatabaseName (
           amount REAL NOT NULL,
           meal_id INTEGER REFERENCES meals,
           ingredient_id INTEGER REFERENCES ingredients
        )''');

    batch.execute('''CREATE TABLE IF NOT EXISTS $_daysDatabaseName (
           id INTEGER PRIMARY KEY,
           glasses_of_water INTEGER NOT NULL,
           practice INTEGER NOT NULL
        )''');

    batch.execute('''CREATE TABLE IF NOT EXISTS $_firstMealInDayDatabaseName (
           id INTEGER PRIMARY KEY,
           amount REAL NOT NULL,
           meal_id INTEGER REFERENCES meals,
           day_id INTEGER REFERENCES days
        )''');

    batch.execute('''CREATE TABLE IF NOT EXISTS $_secondMealInDayDatabaseName (
           id INTEGER PRIMARY KEY,
           amount REAL NOT NULL,
           meal_id INTEGER REFERENCES meals,
           day_id INTEGER REFERENCES days
        )''');

    batch.execute('''CREATE TABLE IF NOT EXISTS $_thirdMealInDayDatabaseName (
           id INTEGER PRIMARY KEY,
           amount REAL NOT NULL,
           meal_id INTEGER REFERENCES meals,
           day_id INTEGER REFERENCES days
        )''');
    await batch.commit(noResult: true);
    _setSettings(db);
  }

  static Future<void> _getSettings(Database db) async {
    Settings.fromMap((await db.query(_settingsDatabaseName, where: "id = 0"))[0]);
  }

  static Future<void> _setSettings(Database db) async {
    await db.insert(_settingsDatabaseName, Settings.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> setSettings() async {
    await _database.insert(_settingsDatabaseName, Settings.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Meal>> getMealInDay(int index, Day day) async {
    String currentTable;
    switch (index) {
      case 1:
        currentTable = _firstMealInDayDatabaseName;
        break;
      case 2:
        currentTable = _secondMealInDayDatabaseName;
        break;
      case 3:
        currentTable = _thirdMealInDayDatabaseName;
        break;
      default:
        return List.empty();
    }

    var list = await _database.query(currentTable, where: "day_id = ${day.id}");
    if (list.length == 0) {
      return List.empty();
    }
    List<Dish> meals = List.empty(growable: true);

    var batch = _database.batch();
    for (int i = 0; i < list.length; i++) {
      await getDish(list[i]["meal_id"]).then((meal) => meals.add(meal));
    }

    await batch.commit();
    List<Meal> mealListElements = List.empty(growable: true);

    for (int i = 0; i < list.length; i++) {
      mealListElements.add(Meal.fromDish(meals[i], list[i]["amount"]));
    }

    return mealListElements;
  }

  static Future<void> addMealToList(int id, Day day, double amount) async {
    String currentTable;

    switch (currentlyEditedMealList) {
      case 1:
        currentTable = _firstMealInDayDatabaseName;
        break;
      case 2:
        currentTable = _secondMealInDayDatabaseName;
        break;
      case 3:
        currentTable = _thirdMealInDayDatabaseName;
        break;
      default:
        return;
    }

    await _database.insert(currentTable, {"amount": amount, "meal_id": id, "day_id": day.id});
  }

  static Future<void> removeMealFromList(int index, int id, Day day) async {
    String currentTable;

    switch (index) {
      case 1:
        currentTable = _firstMealInDayDatabaseName;
        break;
      case 2:
        currentTable = _secondMealInDayDatabaseName;
        break;
      case 3:
        currentTable = _thirdMealInDayDatabaseName;
        break;
      default:
        return;
    }

    await _database.delete(currentTable, where: "meal_id = $id AND day_id = ${day.id}");
  }

  static Future<void> updateDay(Day day) async {
    await _database.update(_daysDatabaseName, day.toMap(), where: "id = ${day.id}");
  }

  static Future<Day> getDay(int id) async {
    var list = await _database.query(_daysDatabaseName, where: "id = $id", columns: ["glasses_of_water", "practice"]);

    if (list.length == 0) {
      var day = Day.empty(id);
      await _database.insert(_daysDatabaseName, day.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      return day;
    }

    int glassesOfWater = list[0]["glasses_of_water"];
    bool practice = list[0]["practice"] != 0 ? true : false;
    return Day(id, glassesOfWater, practice);
  }

  static Future<Ingredient> getIngredient(int id) async {
    var list = await _database.query(_ingredientsDatabaseName, where: "id = $id");

    if (list.length == 0) {
      log("Ingredient not found!");
      return Ingredient();
    }

    return Ingredient.fromMap(list[0]);
  }

  static Future<Map<int, String>> getAllIngredientsNames() async {
    var list = await _database.query(_ingredientsDatabaseName, columns: ["id", "name"]);

    var map = new Map<int, String>();

    list.forEach((e) => map.putIfAbsent(e["id"] as int, () => e["name"]));

    return map;
  }

  static Future<void> addIngredient(Ingredient ingredient) async {
    int maxId = 0;

    maxId = (await _database.rawQuery("SELECT MAX(id) FROM $_ingredientsDatabaseName"))[0]["MAX(id)"];

    if (maxId == null) {
      maxId = 0;
    }

    Map<String, dynamic> ingredientData = ingredient.toMap();
    ingredientData.putIfAbsent("id", () => maxId + 1);
    await _database.insert(_ingredientsDatabaseName, ingredientData);
  }

  static Future<void> removeIngredient(int id) async {
    var batch = _database.batch();

    batch.delete(_ingredientsDatabaseName, where: "id = $id");
    batch.delete(_ingredientsInMealsDatabaseName, where: "ingredient_id = $id");

    await batch.commit(noResult: true);
  }

  static Future<NutritionalValues> getIngredientNutritionalValues(int id) async {
    var ingredient = await _database
        .query(_ingredientsDatabaseName, where: "id = $id", columns: ["calories", "carbohydrates", "fats", "proteins"]);

    return NutritionalValues.fromMap(ingredient[0]);
  }

  static Future<Dish> getDish(int id) async {
    var list = await _database.query(_mealsDatabaseName, where: "id = $id");

    if (list.length == 0) {
      log("Meal not found!");
      return Dish();
    }

    return Dish.fromMap(list[0]);
  }

  static Future<List<IngredientListElement>> getIngredientsOfADish(int dishId) async {
    var ingredientsIdsList = await _database.query(_ingredientsInMealsDatabaseName, where: "meal_id = $dishId");

    var ingredientsList = List<IngredientListElement>.empty(growable: true);
    ingredientsIdsList.forEach((e) async {
      ingredientsList.add(IngredientListElement.fromIngredient(await getIngredient(e["ingredient_id"]), e["amount"]));
    });

    return ingredientsList;
  }

  static Future<Map<int, String>> getAllDishesNames() async {
    var list = await _database.query(_mealsDatabaseName, columns: ["id", "name"]);

    var map = new Map<int, String>();

    list.forEach((e) => map.putIfAbsent(e["id"] as int, () => e["name"]));

    return map;
  }

  static Future<void> addDish(Dish dish, List<IngredientListElement> ingredients) async {
    if (ingredients.length == 0) {
      return;
    }

    int maxId = 0;

    maxId = (await _database.rawQuery("SELECT MAX(id) FROM $_mealsDatabaseName"))[0]["MAX(id)"];

    if (maxId == null) {
      maxId = 0;
    }

    Map<String, dynamic> mealData = dish.toMap();
    mealData.putIfAbsent("id", () => maxId + 1);

    var batch = _database.batch();
    batch.insert(_mealsDatabaseName, mealData);
    ingredients.forEach((element) {
      batch
          .insert(_ingredientsInMealsDatabaseName, {"meal_id": maxId + 1, "ingredient_id": element.id, "amount": element.amount});
    });
    batch.commit(noResult: true);
  }

  static Future<void> removeDish(int id) async {
    var batch = _database.batch();

    batch.delete(_mealsDatabaseName, where: "id = $id");
    batch.delete(_ingredientsInMealsDatabaseName, where: "meal_id = $id");
    batch.delete(_firstMealInDayDatabaseName, where: "meal_id = $id");
    batch.delete(_secondMealInDayDatabaseName, where: "meal_id = $id");
    batch.delete(_thirdMealInDayDatabaseName, where: "meal_id = $id");

    await batch.commit(noResult: true);
  }

  static Future<void> updateDish(Dish dish, List<IngredientListElement> ingredients) async {
    var batch = _database.batch();

    batch.update(_mealsDatabaseName, dish.toMap(), where: "id = ${dish.id}");
    batch.delete(_ingredientsInMealsDatabaseName, where: "meal_id = ${dish.id}");
    ingredients.forEach((element) {
      batch.insert(_ingredientsInMealsDatabaseName, {"meal_id": dish.id, "ingredient_id": element.id, "amount": element.amount});
    });

    await batch.commit(noResult: true);
  }

  static Future<NutritionalValues> getDishNutritionalValues(int id) async {
    var ingredientsList = await _database.query(_ingredientsInMealsDatabaseName, where: "meal_id = $id");

    NutritionalValues values = new NutritionalValues();

    for (int i = 0; i < ingredientsList.length; i++) {
      values += await getIngredientNutritionalValues(ingredientsList[i]["ingredient_id"]) * ingredientsList[i]["amount"];
    }
    return values;
  }

  static Future<NutritionalValues> getDayNutritionalValues(int id) async {
    var ingredientsList = new List.empty(growable: true)
      ..addAll(await _database.query(_firstMealInDayDatabaseName, where: "day_id = $id"))
      ..addAll(await _database.query(_secondMealInDayDatabaseName, where: "day_id = $id"))
      ..addAll(await _database.query(_thirdMealInDayDatabaseName, where: "day_id = $id"));

    NutritionalValues values = new NutritionalValues();

    for (int i = 0; i < ingredientsList.length; i++) {
      values += await getDishNutritionalValues(ingredientsList[i]["meal_id"]) * ingredientsList[i]["amount"];
    }
    return values;
  }
}
