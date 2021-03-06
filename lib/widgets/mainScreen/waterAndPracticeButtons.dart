import 'package:flutter/material.dart';
import 'package:kalories/systems/dataTypes/day.dart';
import 'package:kalories/systems/database/databaseManager.dart';
import 'package:kalories/widgets/common/listItem.dart';
import 'package:kalories/widgets/mainScreen/mainScreen.dart';

class WaterAndPracticeButtons {
  static List<Widget> compose(Day day) {
    List<Widget> list = List<Widget>.empty(growable: true);
    list.add(ListItem(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          child: const Icon(Icons.remove, color: Color(0xFF289CEA), size: 40),
          onPressed: () {
            day.decreaseWaterCounter();
            DatabaseManager.updateDay(day).then((a) => MainScreenState.main.update());
          },
        ),
        Text(
          day.glassesOfWater.toString(),
          style: const TextStyle(fontSize: 30, color: Color(0xFF289CEA)),
        ),
        TextButton(
          child: const Icon(Icons.add, color: Color(0xFF289CEA), size: 40),
          onPressed: () {
            day.increaseWaterCounter();
            DatabaseManager.updateDay(day).then((a) => MainScreenState.main.update());
          },
        )
      ],
    )));

    list.add(ListItem(
        child: TextButton(
            child: Icon(day.practice ? Icons.fitness_center : Icons.fitness_center_outlined,
                color: day.practice ? const Color(0xFFEF651D) : const Color(0xFF1A1A1A), size: 46),
            onPressed: () {
              day.practice = !day.practice;
              DatabaseManager.updateDay(day).then((a) => MainScreenState.main.update());
            })));
    return list;
  }
}
