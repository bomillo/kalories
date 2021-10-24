import 'package:flutter/material.dart';
import 'package:kalories/systems/helpers/mealHelper.dart';
import 'package:kalories/widgets/common/listItem.dart';
import 'package:kalories/widgets/common/selectScreen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectScreen(
        "",
        [
          ListItem(
            child: TextButton(
              child: Text(
                "Nowe danie",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, color: Theme.of(context).accentColor),
              ),
              onPressed: () {
                MealHelper.beginNewMeal();
                _goToAddMeal(context);
              },
            ),
          ),
          ListItem(
            child: TextButton(
              child: Text(
                "Nowy składnik",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, color: Theme.of(context).accentColor),
              ),
              onPressed: () => _goToAddIngredient(context),
            ),
          ),
          ListItem(
            child: TextButton(
              child: Text(
                "Edytuj danie",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, color: Theme.of(context).accentColor),
              ),
              onPressed: () => _goToEditMeal(context),
            ),
          ),
          ListItem(
            child: TextButton(
              child: Text(
                "Usuń danie",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, color: Theme.of(context).accentColor),
              ),
              onPressed: () => _goToRemoveMeal(context),
            ),
          ),
          ListItem(
            child: TextButton(
              child: Text(
                "Usuń składnik",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, color: Theme.of(context).accentColor),
              ),
              onPressed: () => _goToRemoveIngredient(context),
            ),
          )
        ],
      ),
    );
  }

  void _goToAddIngredient(BuildContext context) {
    Navigator.pushNamed(context, '/new/ingredient');
  }

  void _goToAddMeal(BuildContext context) {
    Navigator.pushNamed(context, '/new/meal');
  }

  void _goToRemoveIngredient(BuildContext context) {
    Navigator.pushNamed(context, '/new/ringredient');
  }

  void _goToRemoveMeal(BuildContext context) {
    Navigator.pushNamed(context, '/new/rmeal');
  }

  void _goToEditMeal(BuildContext context) {
    Navigator.pushNamed(context, '/new/emeal');
  }
}
