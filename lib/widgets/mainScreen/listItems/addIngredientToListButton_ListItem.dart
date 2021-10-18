import 'package:flutter/material.dart';
import 'package:flutter_projects/widgets/common/listItem.dart';

class AddIngredientToListItem extends StatelessWidget {
  AddIngredientToListItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListItem(
        child: TextButton(
      child: Icon(Icons.add, color: Theme.of(context).accentColor, size: 40),
      onPressed: () => _changeScreen(context),
    ));
  }

  void _changeScreen(BuildContext context) {
    Navigator.pushNamed(context, '/new/meal/ingredients');
  }
}
