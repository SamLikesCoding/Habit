import 'dart:developer';
import 'package:app/model/habit.dart';
import 'package:hive/hive.dart';

class HabitInfoController {
  Box<HabitObject>? dataBox;
  String habitKey = "";
  HabitInfoController() {
    log("HabitInfoController Initalized");
  }

  Future<bool> initHiveBox(String key) async {
    habitKey = key;
    dataBox = await Hive.openBox<HabitObject>("habits");
    log("Got the data box!");
    return true;
  }

  HabitObject get getObject => dataBox!.get(habitKey)!;

  deleteObject(String key) {
    dataBox!.delete(key);
    log("Habit deleted");
  }

  dispose() {
    dataBox!.close();
  }
}
