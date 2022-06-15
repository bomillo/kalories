import 'package:flutter/material.dart';
import 'package:kalories/systems/dataTypes/nutritionalValues.dart';
import 'package:kalories/systems/dataTypes/settings.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar(this.values, {Key key, this.title, this.unit, this.color, this.category}) : super(key: key);

  final String title;
  final String unit;
  final Color color;
  final NutritionalValuesCategory category;
  final NutritionalValues values;
  @override
  ProgressBarState createState() => ProgressBarState();
}

class ProgressBarState extends State<ProgressBar> {
  ProgressBarState() : super();

  double _getMaxValue() {
    NutritionalValues values = widget.values;
    if (values == null) {
      return 0;
    }
    switch (widget.category) {
      case NutritionalValuesCategory.calories:
        return Settings.current.caloriesTarget;
        break;
      case NutritionalValuesCategory.carbohydrates:
        return Settings.current.carbohydrateTarget;
        break;
      case NutritionalValuesCategory.proteins:
        return Settings.current.proteinsTarget;
        break;
      case NutritionalValuesCategory.fats:
        return Settings.current.fatsTarget;
        break;
      default:
        return 0;
    }
  }

  double _getValue() {
    NutritionalValues values = widget.values;
    if (values == null) {
      return 0;
    }
    switch (widget.category) {
      case NutritionalValuesCategory.calories:
        return values.calories;
        break;
      case NutritionalValuesCategory.carbohydrates:
        return values.carbohydrates;
        break;
      case NutritionalValuesCategory.proteins:
        return values.proteins;
        break;
      case NutritionalValuesCategory.fats:
        return values.fats;
        break;
      default:
        return 0;
    }
  }

  double _getProgress() {
    return _getValue() / _getMaxValue();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 5,
                child: LinearProgressIndicator(
                  value: _getProgress(),
                  backgroundColor: const Color(0xFF222222),
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
                  "${(_getValue()).toStringAsFixed(0)}/${_getMaxValue().toStringAsFixed(0)} ${widget.unit}",
                  style: const TextStyle(fontSize: 11.5, color: Color(0xFF999999)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
