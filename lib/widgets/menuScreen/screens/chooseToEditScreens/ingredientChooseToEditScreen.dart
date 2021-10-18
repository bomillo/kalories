import 'package:flutter/material.dart';
import 'package:flutter_projects/systems/database/databaseManager.dart';
import 'package:flutter_projects/widgets/common/listItem.dart';
import 'package:flutter_projects/widgets/common/selectScreen.dart';

class IngredientChooseToEditScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IngredientChooseToEditState();
  }
}

class IngredientChooseToEditState extends State<IngredientChooseToEditScreen> {
  bool loaded = false;
  Map<int, String> allIngredients = new Map<int, String>();

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      DatabaseManager.getAllIngredientsNames().then((map) {
        setState(() {
          allIngredients = map;
        });
      });
      loaded = true;
    }
    return Scaffold(
      //appBar: AppBar(),
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
            children: (allIngredients.entries.toList()..sort((a, b) => a.value.compareTo(b.value)))
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
                          onPressed: () => _goToAddIngredient(context, e.key),
                        ),
                      ],
                    )))
                .toList(),
          )),
        ],
      ),
    );
  }

  void _goToAddIngredient(BuildContext context, int id) {
    DatabaseManager.removeIngredient(id);
    Navigator.pop(context);
  }
}
