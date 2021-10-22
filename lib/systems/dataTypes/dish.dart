import 'package:Kalories/systems/dataTypes/ingredient.dart';

class Dish {
  Dish();

  int id = 0;

  String name = "";
  String unit = "";

  Map<String, dynamic> toMap() {
    return {"name": name, "unit": unit};
  }

  Dish.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    unit = map["unit"];
  }
}

class Meal {
  int id;

  Dish dish;

  double amount;

  Meal.fromDish(this.dish, this.amount) {
    id = dish.id;
  }
}

class IngredientListElement {
  int id;

  Ingredient ingredient;

  double amount;

  IngredientListElement.fromIngredient(this.ingredient, this.amount) {
    id = ingredient.id;
  }
}
