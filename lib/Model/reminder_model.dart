import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 2)
class ReminderModel extends HiveObject{
  @HiveField(0)
  TimeOfDay? reminder;
  
  @HiveField(1)
  bool isReminderOn = true;

  ReminderModel({
    required this.reminder,
    required this.isReminderOn,
  });
}
