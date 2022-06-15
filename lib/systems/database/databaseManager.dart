import 'dart:async';
import 'dart:io';

import 'package:kalories/systems/dataTypes/day.dart';
import 'package:kalories/systems/dataTypes/ingredient.dart';
import 'package:kalories/systems/dataTypes/meal.dart';
import 'package:kalories/systems/dataTypes/nutritionalValues.dart';
import 'package:kalories/systems/dataTypes/settings.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tuple/tuple.dart';

class DatabaseManager {
  static const _databaseFileName = 'kalories.db';

  static const _ingredientsDatabaseName = 'ingredients';
  static const _mealsDatabaseName = 'meals';
  static const _daysDatabaseName = 'days';
  static const _settingsDatabaseName = 'settings';
  static const _ingredientsInMealsDatabaseName = 'ingredients_in_meals';
  static const _firstMealInDayDatabaseName = 'meal_in_day_1';
  static const _secondMealInDayDatabaseName = 'meal_in_day_2';
  static const _thirdMealInDayDatabaseName = 'meal_in_day_3';

  static Database _database;

  static initializeDatabase() async {
    var dbOptions = OpenDatabaseOptions(version: 1, onCreate: _onCreate, onOpen: _getSettings);
    DatabaseFactory choosenDatabaseFactory;
    if (Platform.isWindows) {
      sqfliteFfiInit();
      choosenDatabaseFactory = databaseFactoryFfi;
    } else if (Platform.isAndroid) {
      choosenDatabaseFactory = databaseFactory;
    }
    _database = await choosenDatabaseFactory.openDatabase(_databaseFileName, options: dbOptions);
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
           meal_id INTEGER REFERENCES $_mealsDatabaseName,
           ingredient_id INTEGER REFERENCES $_ingredientsDatabaseName
        )''');

    batch.execute('''CREATE TABLE IF NOT EXISTS $_daysDatabaseName (
           id INTEGER PRIMARY KEY,
           glasses_of_water INTEGER NOT NULL,
           practice INTEGER NOT NULL
        )''');

    batch.execute('''CREATE TABLE IF NOT EXISTS $_firstMealInDayDatabaseName (
           id INTEGER PRIMARY KEY,
           amount REAL NOT NULL,
           meal_id INTEGER REFERENCES $_mealsDatabaseName,
           day_id INTEGER REFERENCES $_daysDatabaseName
        )''');

    batch.execute('''CREATE TABLE IF NOT EXISTS $_secondMealInDayDatabaseName (
           id INTEGER PRIMARY KEY,
           amount REAL NOT NULL,
           meal_id INTEGER REFERENCES $_mealsDatabaseName,
           day_id INTEGER REFERENCES $_daysDatabaseName
        )''');

    batch.execute('''CREATE TABLE IF NOT EXISTS $_thirdMealInDayDatabaseName (
           id INTEGER PRIMARY KEY,
           amount REAL NOT NULL,
           meal_id INTEGER REFERENCES $_mealsDatabaseName,
           day_id INTEGER REFERENCES $_daysDatabaseName
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
    _setSettings(_database);
  }

  static String _getMealInDayDatabaseName(int listIndex) {
    switch (listIndex) {
      case 1:
        return _firstMealInDayDatabaseName;
        break;
      case 2:
        return _secondMealInDayDatabaseName;
        break;
      case 3:
        return _thirdMealInDayDatabaseName;
        break;
      default:
        return "";
    }
  }

  static Future<Map<Meal, Tuple2<int, double>>> getMealsInDay(int listIndex, Day day) async {
    String currentTable = _getMealInDayDatabaseName(listIndex);
    if (currentTable == "") {
      return <Meal, Tuple2<int, double>>{};
    }

    var list = await _database.query(currentTable, where: "day_id = ${day.id}");

    if (list.isEmpty) {
      return <Meal, Tuple2<int, double>>{};
    }

    Map<Meal, Tuple2<int, double>> mealListElements = <Meal, Tuple2<int, double>>{};

    for (int i = 0; i < list.length; i++) {
      mealListElements.putIfAbsent(await getMeal(list[i]["meal_id"]), () => Tuple2(list[i]["id"], list[i]["amount"]));
    }

    return mealListElements;
  }

  static Future<void> addMealInDay(int listIndex, Day day, Tuple2<int, double> meal) async {
    String currentTable = _getMealInDayDatabaseName(listIndex);
    if (currentTable == "") {
      return;
    }

    int maxId = (await _database.rawQuery("SELECT MAX(id) FROM $currentTable"))[0]["MAX(id)"];
    maxId ??= 0;
    await _database.insert(currentTable, {"id": maxId + 1, "amount": meal.item2, "meal_id": meal.item1, "day_id": day.id});
  }

  static Future<void> removeMealInDay(int listIndex, int id, Day day) async {
    String currentTable = _getMealInDayDatabaseName(listIndex);
    if (currentTable == "") {
      return;
    }

    await _database.delete(currentTable, where: "id = $id AND day_id = ${day.id}");
  }

  static Future<void> updateDay(Day day) async {
    await _database.update(_daysDatabaseName, day.toMap(), where: "id = ${day.id}", conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<Day> getDay(int id) async {
    var list = await _database.query(_daysDatabaseName, where: "id = $id", columns: ["glasses_of_water", "practice"]);

    if (list.isEmpty) {
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

    if (list.isEmpty) {
      return Ingredient();
    }

    return Ingredient.fromMap(list[0]);
  }

  static Future<Map<int, String>> getAllIngredientsNames() async {
    var list = await _database.query(_ingredientsDatabaseName, columns: ["id", "name"]);

    var map = <int, String>{};

    for (var e in list) {
      map.putIfAbsent(e["id"] as int, () => e["name"]);
    }

    return map;
  }

  static Future<void> addIngredient(Ingredient ingredient) async {
    int maxId = 0;

    maxId = (await _database.rawQuery("SELECT MAX(id) FROM $_ingredientsDatabaseName"))[0]["MAX(id)"];

    maxId ??= 0;

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

  static Future<void> removeIngredientFromMeal(int mealId, int ingId) async {
    _database.delete(_ingredientsInMealsDatabaseName, where: "ingredient_id = $ingId and meal_id = $mealId");
  }

  static Future<NutritionalValues> getIngredientNutritionalValues(int id) async {
    var ingredient = await _database.query(_ingredientsDatabaseName, where: "id = $id", columns: ["calories", "carbohydrates", "fats", "proteins"]);

    return NutritionalValues.fromMap(ingredient[0]);
  }

  static Future<Meal> getMeal(int id) async {
    var list = await _database.query(_mealsDatabaseName, where: "id = $id");

    if (list.isEmpty) {
      return Meal();
    }

    return Meal.fromMap(list[0]);
  }

  static Future<Map<Ingredient, double>> _getIngredientsOfMeal(List<Map<String, dynamic>> ids) async {
    var ingredientsMap = <Ingredient, double>{};
    for (var i = 0; i < ids.length; i++) {
      ingredientsMap.putIfAbsent(await getIngredient(ids[i]["ingredient_id"]), () => ids[i]["amount"]);
    }
    return ingredientsMap;
  }

  static Future<Map<Ingredient, double>> getIngredientsOfMeal(int mealId) async {
    var ingredientsIdsList = await _database.query(_ingredientsInMealsDatabaseName, where: "meal_id = $mealId");

    var ingredientsMap = await _getIngredientsOfMeal(ingredientsIdsList);

    return ingredientsMap;
  }

  static Future<Map<int, String>> getAllMealsNames() async {
    var list = await _database.query(_mealsDatabaseName, columns: ["id", "name"]);

    var map = <int, String>{};

    for (var e in list) {
      map.putIfAbsent(e["id"] as int, () => e["name"]);
    }

    return map;
  }

  static Future<void> addNewMeal(Meal meal, Map<Ingredient, double> ingredients) async {
    if (ingredients.isEmpty) {
      return;
    }

    int maxId = 0;

    maxId = (await _database.rawQuery("SELECT MAX(id) FROM $_mealsDatabaseName"))[0]["MAX(id)"];

    maxId ??= 0;

    Map<String, dynamic> mealData = meal.toMap();
    mealData.putIfAbsent("id", () => maxId + 1);

    var batch = _database.batch();
    batch.insert(_mealsDatabaseName, mealData);
    ingredients.forEach((ingredient, amount) {
      batch.insert(_ingredientsInMealsDatabaseName, {"meal_id": maxId + 1, "ingredient_id": ingredient.id, "amount": amount});
    });
    batch.commit(noResult: true);
  }

  static Future<void> removeMeal(int mealId) async {
    var batch = _database.batch();

    batch.delete(_mealsDatabaseName, where: "id = $mealId");
    batch.delete(_ingredientsInMealsDatabaseName, where: "meal_id = $mealId");
    batch.delete(_firstMealInDayDatabaseName, where: "meal_id = $mealId");
    batch.delete(_secondMealInDayDatabaseName, where: "meal_id = $mealId");
    batch.delete(_thirdMealInDayDatabaseName, where: "meal_id = $mealId");

    await batch.commit(noResult: true);
  }

  static Future<void> updateMeal(Meal meal, Map<Ingredient, double> ingredients) async {
    var batch = _database.batch();

    batch.update(_mealsDatabaseName, meal.toMap(), where: "id = ${meal.id}");
    batch.delete(_ingredientsInMealsDatabaseName, where: "meal_id = ${meal.id}");
    ingredients.forEach((ingredient, amount) {
      batch.insert(_ingredientsInMealsDatabaseName, {"meal_id": meal.id, "ingredient_id": ingredient.id, "amount": amount});
    });

    await batch.commit(noResult: true);
  }

  static Future<NutritionalValues> getMealNutritionalValues(int mealId) async {
    var ingredientsList = await _database.query(_ingredientsInMealsDatabaseName, where: "meal_id = $mealId");

    NutritionalValues values = NutritionalValues();

    for (int i = 0; i < ingredientsList.length; i++) {
      values += await getIngredientNutritionalValues(ingredientsList[i]["ingredient_id"]) * ingredientsList[i]["amount"];
    }
    return values;
  }

  static Future<NutritionalValues> getDayNutritionalValues(int dayId) async {
    var mealsList = List.empty(growable: true)
      ..addAll(await _database.query(_firstMealInDayDatabaseName, where: "day_id = $dayId"))
      ..addAll(await _database.query(_secondMealInDayDatabaseName, where: "day_id = $dayId"))
      ..addAll(await _database.query(_thirdMealInDayDatabaseName, where: "day_id = $dayId"));

    NutritionalValues values = NutritionalValues();

    for (int i = 0; i < mealsList.length; i++) {
      values += await getMealNutritionalValues(mealsList[i]["meal_id"]) * mealsList[i]["amount"];
    }
    return values;
  }
}
