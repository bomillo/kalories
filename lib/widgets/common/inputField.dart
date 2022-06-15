import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  const InputField(this.formatter, {Key key, this.title, this.help, this.width = 90, this.defaultValue = "", this.fn}) : super(key: key);

  final String title;
  final String help;
  final String defaultValue;
  final TextInputFormatter formatter;
  final double width;
  final Function(String) fn;

  @override
  Widget build(BuildContext context) {
    String helpString = "";

    if (help.isNotEmpty) {
      helpString = " ($help)";
    }

    TextInputType inputType = TextInputType.number;
    if (formatter != FilteringTextInputFormatter.digitsOnly) {
      inputType = TextInputType.text;
    }

    return Container(
      height: 40,
      margin: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
      child: Stack(children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            title,
            style: const TextStyle(fontSize: 26, color: Color(0xff999999)),
          ),
          Text(
            helpString,
            style: const TextStyle(fontSize: 16, color: Color(0xff777777)),
          ),
        ]),
        Positioned(
            right: 0,
            bottom: 10,
            child: Container(
                width: width,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.secondary)),
                ),
                child: TextField(
                  autocorrect: false,
                  controller: TextEditingController(text: defaultValue),
                  style: const TextStyle(fontSize: 26, color: Color(0xff999999)),
                  decoration: null,
                  keyboardType: inputType,
                  textAlign: TextAlign.end,
                  textAlignVertical: TextAlignVertical.top,
                  onChanged: (string) => fn(string),
                  inputFormatters: <TextInputFormatter>[formatter],
                )))
      ]),
    );
  }
}
