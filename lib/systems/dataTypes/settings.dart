import 'package:flutter_projects/systems/database/databaseManager.dart';

class Settings {
  static Settings current;

  static var caloriesProgressBarSetMax;

  static var carbohydratesProgressBarSetMax;

  static var fatsProgressBarSetMax;

  static var proteinsProgressBarSetMax;

  static var caloriesProgressBarSetVal;

  static var carbohydratesProgressBarSetVal;

  static var fatsProgressBarSetVal;

  static var proteinsProgressBarSetVal;

  Settings() {
    current = this;
    caloriesTarget = 1000;
    carbohydrateTarget = 1000;
    fatsTarget = 1000;
    proteinsTarget = 1000;
  }

  Settings.copy(Settings settings) {
    caloriesTarget = settings.caloriesTarget;
    carbohydrateTarget = settings.carbohydrateTarget;
    fatsTarget = settings.fatsTarget;
    proteinsTarget = settings.proteinsTarget;
  }

  double caloriesTarget;
  double carbohydrateTarget;
  double fatsTarget;
  double proteinsTarget;

  static Map<String, dynamic> toMap() {
    return {
      "id": 0,
      "caloriesTarget": current.caloriesTarget,
      "carbohydrateTarget": current.carbohydrateTarget,
      "fatsTarget": current.fatsTarget,
      "proteinsTarget": current.proteinsTarget
    };
  }

  static void fromMap(Map<dynamic, dynamic> map) {
    current.caloriesTarget = map["caloriesTarget"];
    current.carbohydrateTarget = map["carbohydrateTarget"];
    current.fatsTarget = map["fatsTarget"];
    current.proteinsTarget = map["proteinsTarget"];
  }

  static void save() {
    updateBars();
    DatabaseManager.setSettings();
  }

  static void updateBars() {
    caloriesProgressBarSetMax(current.caloriesTarget);
    carbohydratesProgressBarSetMax(current.carbohydrateTarget);
    fatsProgressBarSetMax(current.fatsTarget);
    proteinsProgressBarSetMax(current.proteinsTarget);
  }
}
