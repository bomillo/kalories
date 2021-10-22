import 'package:flutter/material.dart';

class SelectScreen extends StatelessWidget {
  SelectScreen(this.title, this.children) : super();

  final children;
  final title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Container(
                    padding: EdgeInsetsDirectional.only(start: 30.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 30, color: Color(0xFFFFFFFF)),
                    ))),
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).accentColor,
                ),
                iconSize: 35,
                splashRadius: 20,
                onPressed: () => _goBack(context)),
          ],
        ),
      ]..addAll(children),
    );
  }

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
