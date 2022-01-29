import 'package:hive/hive.dart';
part 'timeRecord.g.dart';

@HiveType(typeId: 1)
class TimeRecord {
  @HiveField(0)
  int seconds = 0;
  @HiveField(1)
  int minutes = 0;
  @HiveField(2)
  int hours = 0;
  TimeRecord();

  String toEnglish() {
    return "$hours hours\n$minutes minutes\n$seconds seconds";
  }

  @override
  String toString() {
    return hours.toString().padLeft(2, "0") +
        ":" +
        minutes.toString().padLeft(2, "0") +
        "." +
        seconds.toString().padLeft(2, "0");
  }
}
