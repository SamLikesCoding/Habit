// ignore_for_file: file_names
import 'dart:developer';
import 'package:app/keygen.dart';
import 'package:app/model/habit.dart';
import 'package:hive/hive.dart';

class AddPageController {
  bool? compSwitch;
  Box<HabitObject>? dataBox;
  HabitObject? object;
  AddPageController() {
    log("AddPageController Initalized");
    compSwitch = true;
    initHiveBox();
  }

  initHiveBox() async {
    dataBox = await Hive.openBox<HabitObject>("habits");
  }

  initHabitObject({
    required String activityName,
    String activityDescription = "",
  }) =>
      object = HabitObject(
        activityName: activityName,
        activityDescription: activityDescription,
      );

  setMeasureType(bool isTimeable, bool isCountable) {
    object!.setCountable(isCountable);
    object!.setTimeable(isTimeable);
  }

  addObject() {
    var key = getRandString(object!.activityName.length);
    dataBox!.put(key, object!);
    log("Habit Added!");
  }

  dispose() {
    dataBox!.close();
  }
}
