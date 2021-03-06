import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalories/systems/dataTypes/settings.dart';
import 'package:kalories/widgets/common/inputField.dart';
import 'package:kalories/widgets/mainScreen/mainScreen.dart';

class SettingsScreen extends StatelessWidget {
  final Settings newSettings = Settings.copy(Settings.current);

  SettingsScreen({Key key}) : super(key: key);

  void _saveSettings() {
    Settings.current = newSettings;
    Settings.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
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
                    _goBackToMainScreen(context);
                  }),
            ],
          ),
          InputField(FilteringTextInputFormatter.digitsOnly,
              title: "Cel kalori",
              help: "kcal",
              defaultValue: newSettings.caloriesTarget.toStringAsFixed(0),
              fn: (String string) => newSettings.caloriesTarget = double.parse(string)),
          InputField(FilteringTextInputFormatter.digitsOnly,
              title: "Cel bia??ek",
              help: "gram",
              defaultValue: newSettings.proteinsTarget.toStringAsFixed(0),
              fn: (String string) => newSettings.proteinsTarget = double.parse(string)),
          InputField(FilteringTextInputFormatter.digitsOnly,
              title: "Cel w??glowodan??w",
              help: "gram",
              defaultValue: newSettings.carbohydrateTarget.toStringAsFixed(0),
              fn: (String string) => newSettings.carbohydrateTarget = double.parse(string)),
          InputField(FilteringTextInputFormatter.digitsOnly,
              title: "Cel t??uszczy",
              help: "gram",
              defaultValue: newSettings.fatsTarget.toStringAsFixed(0),
              fn: (String string) => newSettings.fatsTarget = double.parse(string)),
        ],
      ),
    );
  }

  void _goBackToMainScreen(BuildContext context) {
    Navigator.pop(context);
  }
}
