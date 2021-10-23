import 'package:kalories/systems/dataTypes/ingredient.dart';
import 'package:kalories/systems/database/databaseManager.dart';
import 'package:kalories/widgets/menuScreen/screens/addScreens/addNewDishScreen.dart';

import '../dataTypes/meal.dart';

class DishCreator {
  static Meal dish;
  static Map<Ingredient, double> ingredients;

  static void beginNewMeal() {
    dish = new Meal();
    ingredients = Map<Ingredient, double>();
  }

  static Future<void> loadFromDatabase(int mealId) async {
    dish = await DatabaseManager.getMeal(mealId);
    ingredients = (await DatabaseManager.getIngredientsOfMeal(mealId));
  }

  static Future<void> updateInDatabase() async {
    DatabaseManager.updateMeal(dish, ingredients);
  }

  static void addToDatabase() {
    DatabaseManager.addNewMeal(dish, ingredients);
  }

  static void addIngredient(Ingredient ingredient, double amount) {
    AddNewMealState.main.update();
    ingredients.putIfAbsent(ingredient, () => amount);
  }

  static void removeIngredient(Ingredient ingredient) {
    AddNewMealState.main.update();
    ingredients.removeWhere((ing, _) => ingredient.id == ing.id);
  }
}
