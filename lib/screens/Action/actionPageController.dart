// ignore_for_file: file_names

import 'dart:developer';
import 'package:app/model/habit.dart';
import 'package:hive/hive.dart';

class ActionPageController {
  String habitKey = "";
  Box<HabitObject>? dataBox;
  HabitObject? referenceObject;
  ActionPageController() {
    log("ActionPageController Initalized");
  }

  Future<bool> initHiveBox(String key) async {
    habitKey = key;
    dataBox = await Hive.openBox<HabitObject>("habits");
    referenceObject = dataBox!.get(key);
    return true;
  }

  HabitObject get object => referenceObject!;

  updateCount(int count) {
    referenceObject!.actionCount = count;
    log("Count Updated");
  }

  updateHabit() {
    dataBox!.put(habitKey, referenceObject!);
    log("Habit Updated");
  }
}
