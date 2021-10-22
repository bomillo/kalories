import 'package:flutter/material.dart';
import 'package:Kalories/systems/dataTypes/day.dart';
import 'package:Kalories/systems/dataTypes/dish.dart';
import 'package:Kalories/systems/dataTypes/nutritionalValues.dart';
import 'package:Kalories/systems/database/databaseManager.dart';
import 'package:Kalories/widgets/common/listItem.dart';
import 'package:Kalories/widgets/mainScreen/mainScreen.dart';

class MealListItem extends StatefulWidget {
  MealListItem(this.day, this.id, this.index, this.amount, this.updateCallback, {Key key}) : super(key: key);

  final index;
  final Day day;
  final id;
  final double amount;
  final updateCallback;

  @override
  MealListItemState createState() => MealListItemState();
}

class MealListItemState extends State<MealListItem> {
  bool loaded = false;
  Dish meal = Dish();
  NutritionalValues values = NutritionalValues();

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      DatabaseManager.getDish(widget.id).then((_meal) {
        setState(() {
          meal = _meal;
        });
      });

      DatabaseManager.getDishNutritionalValues(widget.id).then((_values) {
        setState(() {
          values = _values;
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
                        style: TextStyle(fontSize: 30, color: Color(0xFFFFFFFF)),
                      ),
                      Container(
                          child: Text(
                            " ${widget.amount.toStringAsFixed(2)} ${meal.unit}",
                            style: TextStyle(fontSize: 18, color: Color(0xFF767676)),
                          ),
                          margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3))
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  width: 90,
                  height: 23,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${(widget.amount * values.calories).toStringAsFixed(0)}",
                        style: TextStyle(fontSize: 20, color: Color(0xFFf5d41d)),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        " kcal",
                        style: TextStyle(fontSize: 14, color: Color(0xff757576)),
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 110,
                  width: 90,
                  height: 23,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${(widget.amount * values.carbohydrates).toStringAsFixed(0)}",
                        style: TextStyle(fontSize: 20, color: Color(0xFF34c943)),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        " gram",
                        style: TextStyle(fontSize: 14, color: Color(0xff757576)),
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 210,
                  width: 90,
                  height: 23,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${(widget.amount * values.proteins).toStringAsFixed(0)}",
                        style: TextStyle(fontSize: 20, color: Color(0xFFf7f7f7)),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        " gram",
                        style: TextStyle(fontSize: 14, color: Color(0xff757576)),
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 310,
                  width: 90,
                  height: 23,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${(widget.amount * values.fats).toStringAsFixed(0)}",
                        style: TextStyle(fontSize: 20, color: Color(0xFFed4f24)),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
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
          IconButton(
              icon: Icon(Icons.delete), color: Color(0xFF101010), splashRadius: 0.1, iconSize: 40, onPressed: () => _remove())
        ],
      ),
    );
  }

  void _remove() {
    //TODO delete from list
    DatabaseManager.removeMealFromList(widget.index, meal.id, widget.day).then((a) {
      MainScreenState.main.update();
      widget.updateCallback();
    });
  }
}
