import 'package:flutter/material.dart';
import 'package:flutter_projects/systems/dataTypes/nutritionalValues.dart';
import 'package:flutter_projects/systems/dataTypes/settings.dart';

class ProgressBar extends StatefulWidget {
  ProgressBar(this.values, {Key key, this.title, this.unit, this.color, this.category}) : super(key: key);

  final String title;
  final String unit;
  final Color color;
  final NutritionalValuesCategory category;
  final NutritionalValues values;
  @override
  ProgressBarState createState() => ProgressBarState(category);
}

class ProgressBarState extends State<ProgressBar> {
  double _maxValue = 1.0;

  ProgressBarState(NutritionalValuesCategory category) : super() {
    switch (category) {
      case NutritionalValuesCategory.Calories:
        Settings.caloriesProgressBarSetMax = (double newMaxValue) => {updateProgressBarMaxValue(newMaxValue)};
        _maxValue = Settings.current.caloriesTarget;
        break;
      case NutritionalValuesCategory.Carbohydrates:
        Settings.carbohydratesProgressBarSetMax = (double newMaxValue) => {updateProgressBarMaxValue(newMaxValue)};
        _maxValue = Settings.current.carbohydrateTarget;
        break;
      case NutritionalValuesCategory.Proteins:
        Settings.proteinsProgressBarSetMax = (double newMaxValue) => {updateProgressBarMaxValue(newMaxValue)};
        _maxValue = Settings.current.proteinsTarget;
        break;
      case NutritionalValuesCategory.Fats:
        Settings.fatsProgressBarSetMax = (double newMaxValue) => {updateProgressBarMaxValue(newMaxValue)};
        _maxValue = Settings.current.fatsTarget;
        break;
    }
    // DatabaseManager.getDayNutritionalValues(widget.day.id, (values) => updateProgressBarValue(widget.index, values));
  }

  void update({double newMaxValue}) {
    // updateProgressBarValue(newValue);
    updateProgressBarMaxValue(newMaxValue);
  }

/*
  void updateProgressBarValue(double newValue) {
    setState(() {
      _value = newValue;
    });
  }
  */
  double _getValue(NutritionalValuesCategory category) {
    NutritionalValues values = widget.values;
    if (values == null) {
      return 0;
    }
    switch (category) {
      case NutritionalValuesCategory.Calories:
        return values.calories;
        break;
      case NutritionalValuesCategory.Carbohydrates:
        return values.carbohydrates;
        break;
      case NutritionalValuesCategory.Proteins:
        return values.proteins;
        break;
      case NutritionalValuesCategory.Fats:
        return values.fats;
        break;
      default:
        return 0;
    }
  }

  void updateProgressBarMaxValue(double newMaxValue) {
    setState(() {
      _maxValue = newMaxValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    //` DatabaseManager.getDayNutritionalValues(widget.day.id, (values) => updateProgressBarValue(widget.index, values));

    return Expanded(
      child: Container(
        margin: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 5,
                child: LinearProgressIndicator(
                  value: (_getValue(widget.category) / _maxValue),
                  backgroundColor: Color(0xFF222222),
                  valueColor: AlwaysStoppedAnimation<Color>(widget.color),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 14, color: widget.color),
                ),
                Text(
                  "${(_getValue(widget.category)).toStringAsFixed(0)}/${_maxValue.toStringAsFixed(0)} ${widget.unit}",
                  style: TextStyle(fontSize: 11.5, color: Color(0xFF999999)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
