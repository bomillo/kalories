class Ingredient {
  Ingredient();

  int id = 0;

  String name = "";
  String unit = "";

  double calories = 0;
  double carbohydrates = 0;
  double fats = 0;
  double proteins = 0;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "unit": unit,
      "calories": calories,
      "carbohydrates": carbohydrates,
      "fats": fats,
      "proteins": proteins
    };
  }

  Ingredient.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    unit = map["unit"];
    calories = map["calories"];
    carbohydrates = map["carbohydrates"];
    fats = map["fats"];
    proteins = map["proteins"];
  }
}
