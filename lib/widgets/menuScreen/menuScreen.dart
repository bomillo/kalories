import 'package:flutter/material.dart';
import 'package:flutter_projects/systems/helpers/dishCreator.dart';
import 'package:flutter_projects/widgets/common/listItem.dart';
import 'package:flutter_projects/widgets/common/selectScreen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
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
                DishCreator.beginNewMeal();
                _goToAddDish(context);
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
              onPressed: () => _goToEditDish(context),
            ),
          ),
          ListItem(
            child: TextButton(
              child: Text(
                "Edytuj składnik",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, color: Theme.of(context).accentColor),
              ),
              onPressed: () => _goToEditIngredient(context),
            ),
          ),
          ListItem(
            child: TextButton(
              child: Text(
                "Usuń danie",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, color: Theme.of(context).accentColor),
              ),
              onPressed: () => _goToRemoveDish(context),
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

  void _goToAddDish(BuildContext context) {
    Navigator.pushNamed(context, '/new/meal');
  }

  void _goToRemoveIngredient(BuildContext context) {
    Navigator.pushNamed(context, '/new/ringredient');
  }

  void _goToRemoveDish(BuildContext context) {
    Navigator.pushNamed(context, '/new/rmeal');
  }

  void _goToEditIngredient(BuildContext context) {
    Navigator.pushNamed(context, '/new/eingredient');
  }

  void _goToEditDish(BuildContext context) {
    Navigator.pushNamed(context, '/new/emeal');
  }
}
