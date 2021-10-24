import 'package:flutter/material.dart';
import 'package:kalories/systems/database/databaseManager.dart';
import 'package:kalories/systems/helpers/mealHelper.dart';
import 'package:kalories/widgets/common/listItem.dart';
import 'package:kalories/widgets/common/selectScreen.dart';

class MealChooseToEditScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MealChooseToEditState();
  }
}

class MealChooseToEditState extends State<MealChooseToEditScreen> {
  bool loaded = false;
  Map<int, String> allMeals = new Map<int, String>();

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      DatabaseManager.getAllMealsNames().then((map) {
        setState(() {
          allMeals = map;
        });
      });
      loaded = true;
    }
    return Scaffold(
      body: SelectScreen(
        "Wybierz co chcesz edytować",
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
                          child: Icon(Icons.edit, color: Theme.of(context).accentColor, size: 40),
                          onPressed: () => _goToEditMeal(context, e.key),
                        ),
                      ],
                    )))
                .toList(),
          )),
        ],
      ),
    );
  }

  void _goToEditMeal(BuildContext context, int id) {
    MealHelper.loadFromDatabase(id).then((value) => Navigator.pushNamed(context, '/new/emeal/edit'));
  }
}
