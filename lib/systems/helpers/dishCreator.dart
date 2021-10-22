import 'package:Kalories/systems/dataTypes/ingredient.dart';
import 'package:Kalories/systems/database/databaseManager.dart';
import 'package:Kalories/widgets/menuScreen/screens/addScreens/addNewDishScreen.dart';

import '../dataTypes/dish.dart';

class DishCreator {
  static Dish dish;
  static List<IngredientListElement> ingredients;

  static void beginNewMeal() {
    dish = new Dish();
    ingredients = List<IngredientListElement>.empty(growable: true);
  }

  static Future<void> loadFromDatabase(int dishId) async {
    dish = await DatabaseManager.getDish(dishId);
    ingredients = (await DatabaseManager.getIngredientsOfADish(dishId));
  }

  static Future<void> updateInDatabase() async {
    DatabaseManager.updateDish(dish, ingredients);
  }

  static void addToDatabase() {
    DatabaseManager.addDish(dish, ingredients);
  }

  static IngredientListElement currentIngredient() {
    if (ingredients.length != 0) {
      return ingredients.last;
    }
    return null;
  }

  static void setIngredientAmount(amount) {
    if (ingredients.length != 0) {
      ingredients.last.amount = amount;
      AddNewMealState.main.update();
    }
  }

  static void addIngredient(Ingredient ingredient) {
    AddNewMealState.main.update();
    ingredients.add(IngredientListElement.fromIngredient(ingredient, 0));
  }

  static void removeIngredient(Ingredient ingredient) {
    AddNewMealState.main.update();
    ingredients.removeWhere((e) => ingredient.id == e.id);
  }
}
