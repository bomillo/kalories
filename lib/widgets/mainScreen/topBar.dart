import 'package:flutter/material.dart';
import 'package:kalories/widgets/MainScreen/datePicker.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: IconButton(
              icon: Icon(
                Icons.settings_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
              iconSize: 35,
              splashRadius: 40,
              onPressed: () => _goToSettings(context)),
        ),
        const DatePicker(),
        SizedBox(
          height: 50,
          width: 50,
          child: IconButton(
              icon: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.secondary,
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
