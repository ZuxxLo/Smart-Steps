import 'package:hive/hive.dart';

import 'day_model.dart';

part 'habit_model.g.dart';

@HiveType(typeId: 0)
class HabitModel {
  @HiveField(0)
  late String habitName;
  @HiveField(1)
  late List<DayModel> weekList;
  @HiveField(2)
  bool isNotificationsOn = true;  
  @HiveField(3)
 late String emoji ;

  HabitModel(
      {required this.habitName,
      required this.weekList,
      required this.isNotificationsOn,
      required this.emoji});
}
