import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Kalories/systems/dataTypes/settings.dart';
import 'package:Kalories/widgets/common/inputField.dart';
import 'package:Kalories/widgets/mainScreen/mainScreen.dart';

class SettingsScreen extends StatelessWidget {
  final Settings newSettings = Settings.copy(Settings.current);

  void _saveSettings() {
    Settings.current = newSettings;
    Settings.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          _saveSettings();
          MainScreenState.main.update();
          _goBackToMainScreen(context);
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
                    _goBackToMainScreen(context);
                  }),
            ],
          ),
          InputField(FilteringTextInputFormatter.digitsOnly,
              title: "Cel kalori",
              help: "kcal",
              defaultValue: "${newSettings.caloriesTarget.toStringAsFixed(0)}",
              fn: (String string) => newSettings.caloriesTarget = double.parse(string)),
          InputField(FilteringTextInputFormatter.digitsOnly,
              title: "Cel białek",
              help: "gram",
              defaultValue: "${newSettings.proteinsTarget.toStringAsFixed(0)}",
              fn: (String string) => newSettings.proteinsTarget = double.parse(string)),
          InputField(FilteringTextInputFormatter.digitsOnly,
              title: "Cel węglowodanów",
              help: "gram",
              defaultValue: "${newSettings.carbohydrateTarget.toStringAsFixed(0)}",
              fn: (String string) => newSettings.carbohydrateTarget = double.parse(string)),
          InputField(FilteringTextInputFormatter.digitsOnly,
              title: "Cel tłuszczy",
              help: "gram",
              defaultValue: "${newSettings.fatsTarget.toStringAsFixed(0)}",
              fn: (String string) => newSettings.fatsTarget = double.parse(string)),
        ],
      ),
    );
  }

  void _goBackToMainScreen(BuildContext context) {
    Navigator.pop(context);
  }
}
