import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Kalories/systems/dataTypes/day.dart';
import 'package:Kalories/systems/dataTypes/dish.dart';
import 'package:Kalories/systems/database/databaseManager.dart';
import 'package:Kalories/widgets/MainScreen/listItems/addMealToListButton_ListItem.dart';
import 'package:Kalories/widgets/MainScreen/listItems/meal_ListItem.dart';
import 'package:Kalories/widgets/mainScreen/listItems/title_ListItem.dart';

class MealList extends StatefulWidget {
  const MealList(this.index, this.day, this.title, {Key key}) : super(key: key);

  final int index;
  final Day day;
  final String title;

  @override
  State<StatefulWidget> createState() {
    return MealListState();
  }
}

class MealListState extends State<MealList> {
  int dayId;

  List<Meal> list = List<Meal>.empty(growable: true);

  _update() {
    DatabaseManager.getMealInDay(widget.index, widget.day).then((newList) {
      setState(() {
        dayId = widget.day.id;
        list = newList;
      });
    });
  }

  @override
  Widget build(buildContext) {
    if (dayId != widget.day.id) {
      DatabaseManager.getMealInDay(widget.index, widget.day).then((newList) {
        setState(() {
          dayId = widget.day.id;
          list = newList;
        });
      });
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: []
          ..add(TitleListItem(widget.title))
          ..addAll(list.map((e) => MealListItem(widget.day, e.id, widget.index, e.amount, () => _update())))
          ..add(AddMealToListItem(widget.index, widget.day, () => _update())));
  }
}
