import 'package:flutter/material.dart';

class SelectScreen extends StatelessWidget {
  const SelectScreen(this.title, this.children, {Key key}) : super(key: key);

  final List<Widget> children;
  final String title;

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
                    padding: const EdgeInsetsDirectional.only(start: 30.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 30, color: Color(0xFFFFFFFF)),
                    ))),
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                iconSize: 35,
                splashRadius: 20,
                onPressed: () => _goBack(context)),
          ],
        ),
        ...children,
      ],
    );
  }

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
