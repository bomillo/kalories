import 'package:flutter/material.dart';
import 'package:Kalories/systems/dataTypes/settings.dart';
import 'package:Kalories/systems/database/databaseManager.dart';
import 'package:Kalories/widgets/menuScreen/screens/addScreens/addNewIngredientScreen.dart';
import 'package:Kalories/widgets/menuScreen/screens/addScreens/addNewDishScreen.dart';
import 'package:Kalories/widgets/mainScreen/mainScreen.dart';
import 'package:Kalories/widgets/menuScreen/menuScreen.dart';
import 'package:Kalories/widgets/mainScreen/configureScreens/configureIngredient.dart';
import 'package:Kalories/widgets/mainScreen/configureScreens/configureMeal.dart';
import 'package:Kalories/widgets/menuScreen/screens/chooseToEditScreens/dishChooseToEditScreen.dart';
import 'package:Kalories/widgets/menuScreen/screens/chooseToEditScreens/ingredientChooseToEditScreen.dart';
import 'package:Kalories/widgets/menuScreen/screens/editScreens/dishEditScreen.dart';
import 'package:Kalories/widgets/menuScreen/screens/editScreens/ingredientEditScreen.dart';
import 'package:Kalories/widgets/menuScreen/screens/removeScreens/ingredientRemoveScreen.dart';
import 'package:Kalories/widgets/selectScreens/ingredientSelectScreen.dart';
import 'package:Kalories/widgets/menuScreen/screens/removeScreens/dishRemoveScreen.dart';
import 'package:Kalories/widgets/selectScreens/dishSelectScreen.dart';
import 'package:Kalories/widgets/settingsScreen/settingsScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Settings();
  await DatabaseManager.initializeDatabase();
  runApp(Kalories());
}

class Kalories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: Typography.whiteMountainView,
        scaffoldBackgroundColor: Color(0xFF000000),
        backgroundColor: Color(0xFF000000),
        primarySwatch: Colors.pink,
      ),
      routes: {
        '/': (context) => MainScreen(),
        '/settings': (context) => SettingsScreen(),
        '/new': (context) => MenuScreen(),
        '/new/meal': (context) => AddNewDishScreen(),
        '/new/rmeal': (context) => DishRemoveScreen(),
        '/new/emeal': (context) => DishChooseToEditScreen(),
        '/new/emeal/edit': (context) => DishEditScreen(),
        '/new/ingredient': (context) => AddNewIngredientScreen(),
        '/new/ringredient': (context) => IngredientRemoveScreen(),
        '/new/eingredient': (context) => IngredientChooseToEditScreen(),
        '/new/eingredient/edit': (context) => IngredientEditScreen(),
        '/new/meal/ingredients': (context) => IngredientSelectScreen(),
        '/new/meal/ingredients/add': (context) => ConfigureIngredientScreen(),
        '/addMeal': (context) => DishSelectScreen(),
        '/addMeal/add': (context) => ConfigureMealScreen(),
      },
    );
  }
}
