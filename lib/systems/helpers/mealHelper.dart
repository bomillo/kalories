import 'package:kalories/systems/dataTypes/ingredient.dart';
import 'package:kalories/systems/database/databaseManager.dart';

import '../dataTypes/meal.dart';

class MealHelper {
  static Meal meal;
  static Map<Ingredient, double> ingredients;

  static Function() callbackOnChange;

  static void beginNewMeal() {
    meal = new Meal();
    ingredients = Map<Ingredient, double>();
  }

  static Future<void> loadFromDatabase(int mealId) async {
    meal = await DatabaseManager.getMeal(mealId);
    ingredients = await DatabaseManager.getIngredientsOfMeal(mealId);
  }

  static Future<void> updateInDatabase() async {
    await DatabaseManager.updateMeal(meal, ingredients);
  }

  static void addToDatabase() {
    DatabaseManager.addNewMeal(meal, ingredients);
  }

  static void addIngredient(Ingredient ingredient, double amount) {
    callbackOnChange();
    ingredients.putIfAbsent(ingredient, () => amount);
  }

  static void removeIngredient(Ingredient ingredient) {
    callbackOnChange();
    ingredients.removeWhere((ing, _) => ingredient.id == ing.id);
  }
}
