import 'package:flutter/material.dart';
import 'package:kalories/systems/dataTypes/day.dart';
import 'package:kalories/systems/dataTypes/nutritionalValues.dart';
import 'package:kalories/systems/database/databaseManager.dart';
import 'package:kalories/widgets/MainScreen/progressBar.dart';
import 'package:kalories/widgets/MainScreen/topBar.dart';
import 'package:kalories/widgets/mainScreen/mealList.dart';
import 'package:kalories/widgets/mainScreen/waterAndPracticeButtons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  static MainScreenState main;
  int currentlyEditedDay = Day.getIdFor(DateTime.now());

  MainScreenState() : super() {
    main = this;
    currentlyEditedDay = Day.getIdFor(DateTime.now());
    day = Day(main.currentlyEditedDay, 0, false);
  }

  void update() {
    DatabaseManager.getDay(main.currentlyEditedDay).then((newDay) {
      setState(() {
        day = newDay;
      });
    });

    DatabaseManager.getDayNutritionalValues(main.currentlyEditedDay).then((newValues) {
      setState(() {
        values = newValues;
      });
    });
  }

  bool loaded = false;
  Day day; // = new Day(main.currentlyEditedDay, 0, false);
  NutritionalValues values = NutritionalValues();

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      DatabaseManager.getDay(currentlyEditedDay).then((newDay) {
        setState(() {
          day = newDay;
        });
      });

      DatabaseManager.getDayNutritionalValues(currentlyEditedDay).then((newValues) {
        setState(() {
          values = newValues;
        });
      });

      loaded = true;
    }

    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
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
                ..add(MealList(1, day, "??niadanie"))
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
                      ProgressBar(values, title: "KALORIE", unit: "kcal", category: NutritionalValuesCategory.calories, color: const Color(0xFFf5d41d)),
                      ProgressBar(values, title: "BIA??KA", unit: "gram", category: NutritionalValuesCategory.proteins, color: const Color(0xFFf7f7f7)),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      ProgressBar(values,
                          title: "W??GLOWODANY", unit: "gram", category: NutritionalValuesCategory.carbohydrates, color: const Color(0xFF34c943)),
                      ProgressBar(values, title: "T??USZCZE", unit: "gram", category: NutritionalValuesCategory.fats, color: const Color(0xFFed4f24)),
                    ],
                  ))
                ],
              )),
        ],
      ),
    );
  }
}
