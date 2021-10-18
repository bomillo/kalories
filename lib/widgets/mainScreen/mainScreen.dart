import 'package:flutter/material.dart';
import 'package:flutter_projects/systems/dataTypes/day.dart';
import 'package:flutter_projects/systems/dataTypes/nutritionalValues.dart';
import 'package:flutter_projects/systems/database/databaseManager.dart';
import 'package:flutter_projects/widgets/MainScreen/progressBar.dart';
import 'package:flutter_projects/widgets/MainScreen/topBar.dart';
import 'package:flutter_projects/widgets/mainScreen/mealList.dart';
import 'package:flutter_projects/widgets/mainScreen/waterAndPracticeButtons.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    MainScreenState.main = MainScreenState();
    return MainScreenState.main;
  }
}

class MainScreenState extends State<MainScreen> {
  static MainScreenState main;

  MainScreenState() : super() {
    main = this;
  }

  void update() {
    DatabaseManager.getDay(DatabaseManager.currentlyEditedDay).then((newDay) {
      setState(() {
        day = newDay;
      });
    });

    DatabaseManager.getDayNutritionalValues(DatabaseManager.currentlyEditedDay).then((newValues) {
      setState(() {
        values = newValues;
      });
    });
  }

  bool loaded = false;
  Day day = new Day(DatabaseManager.currentlyEditedDay, 0, false);
  NutritionalValues values = new NutritionalValues();

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      DatabaseManager.getDay(DatabaseManager.currentlyEditedDay).then((newDay) {
        setState(() {
          day = newDay;
        });
      });

      DatabaseManager.getDayNutritionalValues(DatabaseManager.currentlyEditedDay).then((newValues) {
        setState(() {
          values = newValues;
        });
      });

      loaded = true;
    }

    return Scaffold(
      //appBar: AppBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            height: 100,
            left: 0,
            right: 0,
            child: TopBar(),
          ),
          Positioned(
            top: 80,
            bottom: 65,
            left: 0,
            right: 0,
            child: ListView(
              padding: EdgeInsetsDirectional.zero,
              children: WaterAndPracticeButtons.compose(day)
                ..add(MealList(1, day, "Śniadanie"))
                ..add(MealList(2, day, "Obiad"))
                ..add(MealList(3, day, "Kolacja")),
            ),
          ),
          Positioned(
              bottom: 0,
              height: 60,
              left: 5,
              right: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      ProgressBar(values,
                          title: "KALORIE", unit: "kcal", category: NutritionalValuesCategory.Calories, color: Color(0xFFf5d41d)),
                      ProgressBar(values,
                          title: "BIAŁKA", unit: "gram", category: NutritionalValuesCategory.Proteins, color: Color(0xFFf7f7f7)),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      ProgressBar(values,
                          title: "WĘGLOWODANY",
                          unit: "gram",
                          category: NutritionalValuesCategory.Carbohydrates,
                          color: Color(0xFF34c943)),
                      ProgressBar(values,
                          title: "TŁUSZCZE", unit: "gram", category: NutritionalValuesCategory.Fats, color: Color(0xFFed4f24)),
                    ],
                  ))
                ],
              )),
        ],
      ),
    );
  }
}
