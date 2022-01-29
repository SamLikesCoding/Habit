// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitObjectAdapter extends TypeAdapter<HabitObject> {
  @override
  final int typeId = 0;

  @override
  HabitObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitObject(
      activityName: fields[0] as String,
      activityDescription: fields[1] as String,
    )
      ..dateCreated = fields[2] as DateTime
      ..actionCount = fields[3] as int
      ..timeTaken = fields[4] as TimeRecord
      ..updateCount = fields[5] as int
      ..updateRecords = (fields[6] as Map).cast<dynamic, dynamic>()
      ..isCountable = fields[7] as bool
      ..isTimable = fields[8] as bool;
  }

  @override
  void write(BinaryWriter writer, HabitObject obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.activityName)
      ..writeByte(1)
      ..write(obj.activityDescription)
      ..writeByte(2)
      ..write(obj.dateCreated)
      ..writeByte(3)
      ..write(obj.actionCount)
      ..writeByte(4)
      ..write(obj.timeTaken)
      ..writeByte(5)
      ..write(obj.updateCount)
      ..writeByte(6)
      ..write(obj.updateRecords)
      ..writeByte(7)
      ..write(obj.isCountable)
      ..writeByte(8)
      ..write(obj.isTimable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
