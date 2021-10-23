class Meal {
  Meal();

  int id = 0;

  String name = "";
  String unit = "";

  Map<String, dynamic> toMap() {
    return {"name": name, "unit": unit};
  }

  Meal.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    unit = map["unit"];
  }
}
