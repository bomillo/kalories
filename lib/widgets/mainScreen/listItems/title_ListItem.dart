import 'package:flutter/material.dart';
import 'package:Kalories/widgets/common/listItem.dart';

class TitleListItem extends StatelessWidget {
  TitleListItem(this.title, {Key key}) : super(key: key);

  final title;

  @override
  Widget build(BuildContext context) {
    return ListItem(
      color: Color(0x00000000),
      height: 25.0,
      child: Container(
        child: Text(
          title,
          style: TextStyle(fontSize: 22, color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
