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
  runApp(const Kalories());
}

class Kalories extends StatelessWidget {
  const Kalories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalories',
      theme: ThemeData(
        textTheme: Typography.whiteMountainView,
        scaffoldBackgroundColor: const Color(0xFF000000),
        backgroundColor: const Color(0xFF000000),
        primarySwatch: Colors.pink,
      ),
      routes: {
        '/': (context) => const MainScreen(),
        '/settings': (context) => SettingsScreen(),
        '/new': (context) => const MenuScreen(),
        '/new/meal': (context) => const AddNewMealScreen(),
        '/new/rmeal': (context) => const MealRemoveScreen(),
        '/new/emeal': (context) => const MealChooseToEditScreen(),
        '/new/emeal/edit': (context) => const MealEditScreen(),
        '/new/ingredient': (context) => AddNewIngredientScreen(),
        '/new/ringredient': (context) => const IngredientRemoveScreen(),
        '/new/meal/ingredients': (context) => const IngredientSelectScreen(),
        '/new/meal/ingredients/add': (context) => ConfigureIngredientScreen(),
        '/addMeal': (context) => const MealSelectScreen(),
        '/addMeal/add': (context) => ConfigureMealScreen(),
      },
    );
  }
}
