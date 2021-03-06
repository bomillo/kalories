import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalories/systems/dataTypes/day.dart';
import 'package:kalories/systems/database/databaseManager.dart';
import 'package:kalories/widgets/common/inputField.dart';
import 'package:kalories/widgets/mainScreen/mainScreen.dart';
import 'package:tuple/tuple.dart';

// ignore: must_be_immutable
class ConfigureMealScreen extends StatelessWidget {
  double amount;
  static int id;
  static int listIndex;
  static Day day;

  static Function() callback;

  ConfigureMealScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          if (amount == null || amount == 0) {
            _goBack(context);
          }
          DatabaseManager.addMealInDay(listIndex, day, Tuple2(id, amount)).then((a) {
            callback();
            MainScreenState.main.update();
          });
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
                        "Ustawienia",
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
                  onPressed: () {
                    _goBack(context);
                  }),
            ],
          ),
          InputField(FilteringTextInputFormatter.digitsOnly,
              title: "Ilo????", help: "", defaultValue: "${0}", fn: (String string) => amount = double.parse(string)),
        ],
      ),
    );
  }

  void _goBack(BuildContext context) {
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
