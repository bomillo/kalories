import 'package:flutter/material.dart';
import 'package:Kalories/systems/dataTypes/day.dart';
import 'package:Kalories/systems/database/databaseManager.dart';
import 'package:Kalories/widgets/common/listItem.dart';
import 'package:Kalories/widgets/mainScreen/configureScreens/configureMeal.dart';

class AddMealToListItem extends StatelessWidget {
  AddMealToListItem(this.index, this.day, this.callback, {Key key}) : super(key: key);
  final index;
  final Day day;
  final callback;
  @override
  Widget build(BuildContext context) {
    return ListItem(
        child: TextButton(
      child: Icon(Icons.add, color: Theme.of(context).accentColor, size: 40),
      onPressed: () => _changeScreen(context),
    ));
  }

  void _changeScreen(BuildContext context) {
    DatabaseManager.currentlyEditedMealList = index;
    ConfigureMealScreen.day = day;
    ConfigureMealScreen.callback = callback;
    Navigator.pushNamed(context, '/addMeal');
  }
}
