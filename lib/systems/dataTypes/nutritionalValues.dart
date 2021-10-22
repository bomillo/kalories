enum NutritionalValuesCategory { Calories, Carbohydrates, Fats, Proteins }

class NutritionalValues {
  NutritionalValues();

  double calories = 0;
  double carbohydrates = 0;
  double fats = 0;
  double proteins = 0;

  operator +(NutritionalValues other) {
    calories += other.calories;
    carbohydrates += other.carbohydrates;
    fats += other.fats;
    proteins += other.proteins;
    return this;
  }

  operator *(num other) {
    calories *= other;
    carbohydrates *= other;
    fats *= other;
    proteins *= other;

    return this;
  }

  NutritionalValues.fromMap(Map<String, dynamic> map) {
    calories = map["calories"];
    carbohydrates = map["carbohydrates"];
    fats = map["fats"];
    proteins = map["proteins"];
  }
}
