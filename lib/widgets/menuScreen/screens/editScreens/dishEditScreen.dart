import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects/systems/dataTypes/dish.dart';
import 'package:flutter_projects/systems/helpers/dishCreator.dart';
import 'package:flutter_projects/widgets/common/inputField.dart';
import 'package:flutter_projects/widgets/common/listItem.dart';
import 'package:flutter_projects/widgets/mainScreen/listItems/addIngredientToListButton_ListItem.dart';

class DishEditScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DishEditState();
  }
}

class DishEditState extends State<DishEditScreen> {
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
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
                        "Edytuj danie",
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
            defaultValue: DishCreator.dish.name,
            fn: (String string) => DishCreator.dish.name = string,
          ),
          InputField(FilteringTextInputFormatter.singleLineFormatter,
              title: "Jednostka", help: "", width: 250, defaultValue: DishCreator.dish.unit, fn: (string) => _setUnit(string)),
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
                          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                            Container(
                                margin: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                                child: Text(
                                  "${e.amount}",
                                  style: TextStyle(fontSize: 30, color: Color(0xFFFFFFFF)),
                                )),
                            IconButton(
                                icon: Icon(Icons.delete, color: Theme.of(context).accentColor, size: 40),
                                onPressed: () => DishCreator.removeIngredient(e.ingredient)),
                          ]),
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