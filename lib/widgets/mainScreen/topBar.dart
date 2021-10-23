import 'package:flutter/material.dart';
import 'package:kalories/widgets/MainScreen/datePicker.dart';

class TopBar extends StatelessWidget {
  TopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          child: IconButton(
              icon: Icon(
                Icons.settings_rounded,
                color: Theme.of(context).accentColor,
              ),
              iconSize: 35,
              splashRadius: 40,
              onPressed: () => _goToSettings(context)),
        ),
        DatePicker(),
        Container(
          height: 50,
          width: 50,
          child: IconButton(
              icon: Icon(
                Icons.add,
                color: Theme.of(context).accentColor,
              ),
              iconSize: 35,
              splashRadius: 20,
              onPressed: () => _goToAdding(context)),
        )
      ],
    );
  }

  void _goToSettings(BuildContext context) {
    Navigator.pushNamed(context, '/settings');
  }

  void _goToAdding(BuildContext context) {
    Navigator.pushNamed(context, '/new');
  }
}
