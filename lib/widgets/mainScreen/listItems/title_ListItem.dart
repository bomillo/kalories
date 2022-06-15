import 'package:flutter/material.dart';
import 'package:kalories/widgets/common/listItem.dart';

class TitleListItem extends StatelessWidget {
  const TitleListItem(this.title, {Key key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListItem(
      color: const Color(0x00000000),
      height: 25.0,
      child: Text(
        title,
        style: TextStyle(fontSize: 22, color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
