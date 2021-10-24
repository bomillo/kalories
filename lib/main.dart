import 'package:flutter/material.dart';
import 'package:kalories/systems/dataTypes/settings.dart';
import 'package:kalories/systems/database/databaseManager.dart';
import 'package:kalories/widgets/menuScreen/screens/addScreens/addNewIngredientScreen.dart';
import 'package:kalories/widgets/menuScreen/screens/addScreens/addNewMealScreen.dart';
import 'package:kalories/widgets/mainScreen/mainScreen.dart';
import 'package:kalories/widgets/menuScreen/menuScreen.dart';
import 'package:kalories/widgets/mainScreen/configureScreens/configureIngredient.dart';
import 'package:kalories/widgets/mainScreen/configureScreens/configureMeal.dart';
import 'package:kalories/widgets/menuScreen/screens/chooseToEditScreens/mealChooseToEditScreen.dart';
import 'package:kalories/widgets/menuScreen/screens/editScreens/mealEditScreen.dart';
import 'package:kalories/widgets/menuScreen/screens/removeScreens/ingredientRemoveScreen.dart';
import 'package:kalories/widgets/selectScreens/ingredientSelectScreen.dart';
import 'package:kalories/widgets/menuScreen/screens/removeScreens/mealRemoveScreen.dart';
import 'package:kalories/widgets/selectScreens/mealSelectScreen.dart';
import 'package:kalories/widgets/settingsScreen/settingsScreen.dart';

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
        '/new/meal': (context) => AddNewMealScreen(),
        '/new/rmeal': (context) => MealRemoveScreen(),
        '/new/emeal': (context) => MealChooseToEditScreen(),
        '/new/emeal/edit': (context) => MealEditScreen(),
        '/new/ingredient': (context) => AddNewIngredientScreen(),
        '/new/ringredient': (context) => IngredientRemoveScreen(),
        '/new/meal/ingredients': (context) => IngredientSelectScreen(),
        '/new/meal/ingredients/add': (context) => ConfigureIngredientScreen(),
        '/addMeal': (context) => MealSelectScreen(),
        '/addMeal/add': (context) => ConfigureMealScreen(),
      },
    );
  }
}
