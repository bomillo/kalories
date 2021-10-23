import 'package:flutter/material.dart';
import 'package:Kalories/widgets/mainScreen/configureScreens/configureIngredient.dart';
import 'package:Kalories/systems/database/databaseManager.dart';
import 'package:Kalories/widgets/common/listItem.dart';
import 'package:Kalories/widgets/common/selectScreen.dart';

class IngredientSelectScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IngredientSelectState();
  }
}

class IngredientSelectState extends State<IngredientSelectScreen> {
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
      body: SelectScreen(
        "Wybierz składnik",
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
                          child: Icon(Icons.add, color: Theme.of(context).accentColor, size: 40),
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
    DatabaseManager.getIngredient(id).then((ingredient) {
      ConfigureIngredientScreen.ingredient = ingredient;
      Navigator.pushNamed(context, '/new/meal/ingredients/add');
    });
  }
}
