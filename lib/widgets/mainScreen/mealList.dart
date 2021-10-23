import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalories/systems/dataTypes/day.dart';
import 'package:kalories/systems/dataTypes/meal.dart';
import 'package:kalories/systems/database/databaseManager.dart';
import 'package:kalories/widgets/MainScreen/listItems/addMealToListButton_ListItem.dart';
import 'package:kalories/widgets/MainScreen/listItems/meal_ListItem.dart';
import 'package:kalories/widgets/mainScreen/listItems/title_ListItem.dart';
import 'package:tuple/tuple.dart';

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

  Map<Meal, Tuple2<int, double>> mealAmountMap = Map<Meal, Tuple2<int, double>>();

  _update() {
    DatabaseManager.getMealsInDay(widget.index, widget.day).then((newList) {
      setState(() {
        dayId = widget.day.id;
        mealAmountMap = newList;
      });
    });
  }

  @override
  Widget build(buildContext) {
    if (dayId != widget.day.id) {
      DatabaseManager.getMealsInDay(widget.index, widget.day).then((newList) {
        setState(() {
          dayId = widget.day.id;
          mealAmountMap = newList;
        });
      });
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: []
          ..add(TitleListItem(widget.title))
          ..addAll(mealAmountMap.entries
              .map((e) => MealListItem(widget.day, e.value.item1, e.key.id, widget.index, e.value.item2, () => _update())))
          ..add(AddMealToListItem(widget.index, widget.day, () => _update())));
  }
}
