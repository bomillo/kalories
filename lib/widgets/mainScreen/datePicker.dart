import 'package:flutter/material.dart';
import 'package:Kalories/systems/dataTypes/day.dart';
import 'package:Kalories/systems/database/databaseManager.dart';
import 'package:Kalories/widgets/mainScreen/mainScreen.dart';

class DatePicker extends StatefulWidget {
  DatePicker({Key key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _currentDateOnDisplay = DateTime.now();

  _DatePickerState() : super() {
    _currentDateOnDisplay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 60,
          child: IconButton(
              icon: Icon(
                Icons.arrow_left,
                color: Color(0xFF999999),
              ),
              iconSize: 50,
              splashRadius: 40,
              onPressed: () => _laterDate()),
        ),
        Text(
          _convertDateToString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 26, color: Color(0xFFFFFFFF)),
        ),
        Container(
          height: 100,
          width: 60,
          child: IconButton(
              icon: Icon(
                Icons.arrow_right,
                color: Color(0xFF999999),
              ),
              iconSize: 50,
              splashRadius: 40,
              onPressed: () => _earlierDate()),
        )
      ],
    ));
  }

  void _earlierDate() {
    if (!_currentDateOnDisplay.add(Duration(days: 1)).isAfter(DateTime.now())) {
      setState(() {
        _currentDateOnDisplay = _currentDateOnDisplay.add(Duration(days: 1));
      });
      DatabaseManager.currentlyEditedDay = Day.getIdFor(_currentDateOnDisplay);

      MainScreenState.main.update();
    }
  }

  void _laterDate() {
    setState(() {
      _currentDateOnDisplay = _currentDateOnDisplay.subtract(Duration(days: 1));
    });
    DatabaseManager.currentlyEditedDay = Day.getIdFor(_currentDateOnDisplay);

    MainScreenState.main.update();
  }

  String _convertDateToString() {
    String string = " ";
    switch (_currentDateOnDisplay.weekday) {
      case 1:
        string += "Pon";
        break;
      case 2:
        string += "Wt";
        break;
      case 3:
        string += "Śr";
        break;
      case 4:
        string += "Czw";
        break;
      case 5:
        string += "Pi";
        break;
      case 6:
        string += "Sob";
        break;
      case 7:
        string += "Ni";
        break;
    }

    string += ", " +
        _currentDateOnDisplay.day.toString() +
        "." +
        _currentDateOnDisplay.month.toString() +
        "." +
        _currentDateOnDisplay.year.toString();

    return string;
  }
}
