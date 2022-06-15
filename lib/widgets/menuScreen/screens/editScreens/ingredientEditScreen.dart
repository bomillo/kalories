import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalories/systems/dataTypes/ingredient.dart';
import 'package:kalories/systems/database/databaseManager.dart';
import 'package:kalories/widgets/common/inputField.dart';

class IngredientEditScreen extends StatelessWidget {
  final Ingredient newIng = Ingredient();

  IngredientEditScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          DatabaseManager.addIngredient(newIng);
          _goBack(context);
        },
      ),
      body: Column(
        children: [
          Container(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsetsDirectional.only(start: 30.0),
                      child: const Text(
                        "Dodaj nowy składnik",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 30, color: Color(0xFFFFFFFF)),
                      ))),
              IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  iconSize: 35,
                  splashRadius: 20,
                  onPressed: () => _goBack(context)),
            ],
          ),
          InputField(FilteringTextInputFormatter.singleLineFormatter, title: "Nazwa", help: "", width: 250, fn: (string) => _setName(string)),
          InputField(FilteringTextInputFormatter.singleLineFormatter, title: "Jednostka", help: "", width: 250, fn: (string) => _setUnit(string)),
          Container(height: 40),
          InputField(FilteringTextInputFormatter.digitsOnly, title: "Kalorie", help: "kcal", fn: (string) => _setCalories(string)),
          InputField(FilteringTextInputFormatter.digitsOnly, title: "Białeka", help: "gram", fn: (string) => _setProteins(string)),
          InputField(FilteringTextInputFormatter.digitsOnly, title: "Węglowodany", help: "gram", fn: (string) => _setCarbohydrates(string)),
          InputField(FilteringTextInputFormatter.digitsOnly, title: "Tłuszcze", help: "gram", fn: (string) => _setFats(string)),
        ],
      ),
    );
  }

  void _setName(String string) {
    newIng.name = string;
  }

  void _setUnit(String string) {
    newIng.unit = string;
  }

  void _setCalories(String string) {
    newIng.calories = double.parse(string);
  }

  void _setProteins(String string) {
    newIng.proteins = double.parse(string);
  }

  void _setCarbohydrates(String string) {
    newIng.carbohydrates = double.parse(string);
  }

  void _setFats(String string) {
    newIng.fats = double.parse(string);
  }

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
