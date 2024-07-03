import 'package:hive/hive.dart';
import 'package:momentum/Model/reminder_model.dart';

part 'day_model.g.dart';

@HiveType(typeId: 1)
class DayModel {
  @HiveField(0)
  late int day;
  @HiveField(1)
  late String dayName;
  @HiveField(2)
  late int frequency;
  @HiveField(3)
  late List<ReminderModel> reminders;

  DayModel(
      {required this.day,
      required this.dayName,
      required this.frequency,
      required this.reminders});
}


