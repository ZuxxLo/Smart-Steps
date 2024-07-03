// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayModelAdapter extends TypeAdapter<DayModel> {
  @override
  final int typeId = 1;

  @override
  DayModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayModel(
      day: fields[0] as int,
      dayName: fields[1] as String,
      frequency: fields[2] as int,
      reminders: (fields[3] as List).cast<ReminderModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, DayModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.dayName)
      ..writeByte(2)
      ..write(obj.frequency)
      ..writeByte(3)
      ..write(obj.reminders);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
