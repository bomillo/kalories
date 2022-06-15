import 'package:flutter/material.dart';
import 'package:kalories/widgets/common/listItem.dart';

class AddIngredientToListItem extends StatelessWidget {
  const AddIngredientToListItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListItem(
        child: TextButton(
      child: Icon(Icons.add, color: Theme.of(context).colorScheme.secondary, size: 40),
      onPressed: () => _changeScreen(context),
    ));
  }

  void _changeScreen(BuildContext context) {
    Navigator.pushNamed(context, '/new/meal/ingredients');
  }
}
