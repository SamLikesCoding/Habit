// ignore_for_file: file_names

import 'dart:developer';
import 'package:app/model/habit.dart';
import 'package:hive/hive.dart';

class ViewHabitController {
  Map<dynamic, HabitObject>? habitMap;
  bool readyForfetch = false;
  ViewHabitController() {
    log(" ViewHabitController Initlized ");
  }

  Future<bool> initHiveBox() async {
    await Hive.openBox<HabitObject>("habits").then((instance) {
      log("dataBox status : OK");
      habitMap = instance.toMap();

      readyForfetch = true;
    });
    return true;
  }

  getKey(HabitObject object) {
    return habitMap!.keys
        .firstWhere((key) => habitMap![key] == object, orElse: () => null);
  }

  List<HabitObject> get getHabitList => habitMap!.values.toList();

  dispose() {
    habitMap!.clear();
  }
}
