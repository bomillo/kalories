import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Kalories/systems/helpers/dishCreator.dart';
import 'package:Kalories/widgets/common/inputField.dart';
import 'package:Kalories/widgets/common/listItem.dart';
import 'package:Kalories/widgets/mainScreen/listItems/addIngredientToListButton_ListItem.dart';

class AddNewDishScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    AddNewMealState.main = AddNewMealState();
    return AddNewMealState.main;
  }
}

class AddNewMealState extends State<AddNewDishScreen> {
  static AddNewMealState main;
  AddNewMealState() : super() {
    main = this;
  }

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          DishCreator.addToDatabase();
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
                      padding: EdgeInsetsDirectional.only(start: 30.0),
                      child: Text(
                        "Dodaj nowe danie",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 30.0, color: Color(0xFFFFFFFF)),
                      ))),
              IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).accentColor,
                  ),
                  iconSize: 35.0,
                  splashRadius: 20.0,
                  onPressed: () => _goBack(context)),
            ],
          ),
          InputField(
            FilteringTextInputFormatter.singleLineFormatter,
            title: "Nazwa",
            help: "",
            width: 250.0,
            fn: (String string) => DishCreator.dish.name = string,
          ),
          InputField(FilteringTextInputFormatter.singleLineFormatter,
              title: "Jednostka", help: "", width: 250, fn: (string) => _setUnit(string)),
          Expanded(
              child: ListView(
            padding: EdgeInsetsDirectional.zero,
            children: <Widget>[]
              ..addAll(DishCreator.ingredients
                  .map((e) => ListItem(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                            Container(
                                margin: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                                child: Text(
                                  "${e.ingredient.name}",
                                  style: TextStyle(fontSize: 30, color: Color(0xFFFFFFFF)),
                                )),
                            Container(
                                margin: EdgeInsetsDirectional.fromSTEB(3, 10, 10, 10),
                                child: Text(
                                  "(${e.ingredient.unit})",
                                  style: TextStyle(fontSize: 20, color: Color(0xFFaaaaaa)),
                                )),
                          ]),
                          Container(
                              margin: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                              child: Text(
                                "${e.amount}",
                                style: TextStyle(fontSize: 30, color: Color(0xFFFFFFFF)),
                              )),
                        ],
                      )))
                  .toList())
              ..add(AddIngredientToListItem()),
          )),
        ],
      ),
    );
  }

  void _setUnit(String string) {
    DishCreator.dish.unit = string;
  }

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
