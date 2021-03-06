import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key key, this.child, this.color = const Color(0xFF222222), this.height = 75.0}) : super(key: key);

  final Widget child;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
      decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), color: color),
      child: child,
    );
  }
}
