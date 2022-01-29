import 'package:app/model/timeRecord.dart';
import 'package:hive/hive.dart';
part 'habit.g.dart';

@HiveType(typeId: 0)
class HabitObject {
  @HiveField(0)
  final String activityName;
  @HiveField(1)
  final String activityDescription;
  @HiveField(2)
  DateTime dateCreated = DateTime.now();
  @HiveField(3)
  int actionCount = 0;
  @HiveField(4)
  TimeRecord timeTaken = TimeRecord();
  @HiveField(5)
  int updateCount = 0;
  @HiveField(6)
  Map updateRecords = {};
  @HiveField(7)
  bool isCountable = false;
  @HiveField(8)
  bool isTimable = false;

  HabitObject({
    required this.activityName,
    this.activityDescription = "No Activity Description",
  });

  // Toggle functions for monitor parameters
  setTimeable(bool value) => isTimable = value;
  setCountable(bool value) => isCountable = value;
}
