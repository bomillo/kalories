import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalories/systems/helpers/mealHelper.dart';
import 'package:kalories/widgets/common/inputField.dart';
import 'package:kalories/widgets/common/listItem.dart';
import 'package:kalories/widgets/mainScreen/listItems/addIngredientToListButton_ListItem.dart';

class AddNewMealScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddNewMealState();
  }
}

class AddNewMealState extends State<AddNewMealScreen> {
  AddNewMealState() : super() {
    MealHelper.beginNewMeal();
    MealHelper.callbackOnChange = update;
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
          MealHelper.addToDatabase();
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
            defaultValue: MealHelper.meal.name,
            fn: (String string) => MealHelper.meal.name = string,
          ),
          InputField(FilteringTextInputFormatter.singleLineFormatter,
              title: "Jednostka",
              help: "",
              width: 250,
              defaultValue: MealHelper.meal.unit,
              fn: (string) => MealHelper.meal.unit = string),
          Expanded(
              child: ListView(
            padding: EdgeInsetsDirectional.zero,
            children: <Widget>[]
              ..addAll(MealHelper.ingredients.entries
                  .map((e) => ListItem(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                            Container(
                                margin: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                                child: Text(
                                  "${e.key.name}",
                                  style: TextStyle(fontSize: 30, color: Color(0xFFFFFFFF)),
                                )),
                            Container(
                                margin: EdgeInsetsDirectional.fromSTEB(3, 10, 10, 10),
                                child: Text(
                                  "(${e.key.unit})",
                                  style: TextStyle(fontSize: 20, color: Color(0xFFaaaaaa)),
                                )),
                          ]),
                          Container(
                              margin: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                              child: Text(
                                "${e.value}",
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

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
