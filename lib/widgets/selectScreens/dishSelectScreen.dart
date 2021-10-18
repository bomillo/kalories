import 'package:flutter/material.dart';
import 'package:flutter_projects/systems/database/databaseManager.dart';
import 'package:flutter_projects/widgets/common/listItem.dart';
import 'package:flutter_projects/widgets/mainScreen/configureScreens/configureMeal.dart';
import 'package:flutter_projects/widgets/common/selectScreen.dart';

class DishSelectScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DishSelectState();
  }
}

class DishSelectState extends State<DishSelectScreen> {
  bool loaded = false;
  Map<int, String> allMeals = new Map<int, String>();

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      DatabaseManager.getAllDishesNames().then((map) {
        setState(() {
          allMeals = map;
        });
      });
      loaded = true;
    }
    return Scaffold(
      body: SelectScreen(
        "Wybierz danie",
        <Widget>[
          Container(
            height: 40,
            margin: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
            child: Stack(children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(
                  "Nazwa",
                  style: TextStyle(fontSize: 26, color: Color(0xff999999)),
                ),
                Text(
                  "",
                  style: TextStyle(fontSize: 16, color: Color(0xff777777)),
                ),
              ])
            ]),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsetsDirectional.zero,
            children: (allMeals.entries.toList()..sort((a, b) => a.value.compareTo(b.value)))
                .map((e) => ListItem(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Text(
                              "${e.value}",
                              style: TextStyle(fontSize: 30, color: Color(0xFFFFFFFF)),
                            )),
                        TextButton(
                          child: Icon(Icons.add, color: Theme.of(context).accentColor, size: 40),
                          onPressed: () => _goToAddMeal(context, e.key),
                        ),
                      ],
                    )))
                .toList(),
          )),
        ],
      ),
    );
  }

  void _goToAddMeal(BuildContext context, int id) {
    ConfigureMealScreen.id = id;

    Navigator.pushNamed(context, '/addMeal/add');
  }
}