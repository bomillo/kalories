import 'package:flutter/material.dart';
import 'package:kalories/systems/dataTypes/day.dart';
import 'package:kalories/systems/dataTypes/meal.dart';
import 'package:kalories/systems/dataTypes/nutritionalValues.dart';
import 'package:kalories/systems/database/databaseManager.dart';
import 'package:kalories/widgets/common/listItem.dart';
import 'package:kalories/widgets/mainScreen/mainScreen.dart';

class MealListItem extends StatefulWidget {
  const MealListItem(this.day, this.idInList, this.mealId, this.index, this.amount, this.updateCallback, {Key key}) : super(key: key);

  final int index;
  final Day day;
  final int idInList;
  final int mealId;
  final double amount;
  final Function updateCallback;

  @override
  MealListItemState createState() => MealListItemState();
}

class MealListItemState extends State<MealListItem> {
  bool loaded = false;
  Meal meal = Meal();
  NutritionalValues values = NutritionalValues();

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      DatabaseManager.getMeal(widget.mealId).then((meal) {
        setState(() {
          meal = meal;
        });
      });

      DatabaseManager.getMealNutritionalValues(widget.mealId).then((values) {
        setState(() {
          values = values;
        });
      });
      loaded = true;
    }

    return ListItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        meal.name,
                        style: const TextStyle(fontSize: 30, color: Color(0xFFFFFFFF)),
                      ),
                      Container(
                          margin: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                          child: Text(
                            " ${widget.amount.toStringAsFixed(2)} ${meal.unit}",
                            style: const TextStyle(fontSize: 18, color: Color(0xFF767676)),
                          ))
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  width: 60,
                  height: 23,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        (widget.amount * values.calories).toStringAsFixed(0),
                        style: const TextStyle(fontSize: 20, color: Color(0xFFf5d41d)),
                        overflow: TextOverflow.fade,
                      ),
                      const Text(
                        " kcal",
                        style: TextStyle(fontSize: 14, color: Color(0xff757576)),
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 90,
                  width: 60,
                  height: 23,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        (widget.amount * values.carbohydrates).toStringAsFixed(0),
                        style: const TextStyle(fontSize: 20, color: Color(0xFF34c943)),
                        overflow: TextOverflow.fade,
                      ),
                      const Text(
                        " gram",
                        style: TextStyle(fontSize: 14, color: Color(0xff757576)),
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 170,
                  width: 60,
                  height: 23,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        (widget.amount * values.proteins).toStringAsFixed(0),
                        style: const TextStyle(fontSize: 20, color: Color(0xFFf7f7f7)),
                        overflow: TextOverflow.fade,
                      ),
                      const Text(
                        " gram",
                        style: TextStyle(fontSize: 14, color: Color(0xff757576)),
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 250,
                  width: 60,
                  height: 23,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        (widget.amount * values.fats).toStringAsFixed(0),
                        style: const TextStyle(fontSize: 20, color: Color(0xFFed4f24)),
                        overflow: TextOverflow.fade,
                      ),
                      const Text(
                        " gram",
                        style: TextStyle(fontSize: 14, color: Color(0xff757576)),
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.delete), color: const Color(0xFF101010), splashRadius: 0.1, iconSize: 40, onPressed: () => _remove())
        ],
      ),
    );
  }

  void _remove() {
    DatabaseManager.removeMealInDay(widget.index, widget.idInList, widget.day).then((a) {
      MainScreenState.main.update();
      widget.updateCallback();
    });
  }
}
