import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Kalories/systems/helpers/dishCreator.dart';
import 'package:Kalories/widgets/common/inputField.dart';
import 'package:Kalories/systems/dataTypes/ingredient.dart';

// ignore: must_be_immutable
class ConfigureIngredientScreen extends StatelessWidget {
  static Ingredient ingredient;
  double amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (amount == null || amount == 0) {
            _goBack(context);
          }
          DishCreator.addIngredient(ingredient, amount);
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
                      padding: EdgeInsetsDirectional.only(start: 30.0),
                      child: Text(
                        "Ustawienia",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 30, color: Color(0xFFFFFFFF)),
                      ))),
              IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).accentColor,
                  ),
                  iconSize: 35,
                  splashRadius: 20,
                  onPressed: () {
                    _goBack(context);
                  }),
            ],
          ),
          InputField(FilteringTextInputFormatter.digitsOnly,
              title: "Ilość",
              help: ingredient.unit,
              defaultValue: "${0}",
              fn: (String string) => amount = double.tryParse(string) ?? (0.0)),
        ],
      ),
    );
  }

  void _goBack(BuildContext context) {
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
