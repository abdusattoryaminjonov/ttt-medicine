import 'package:hive/hive.dart';
part "pill_model.g.dart";

@HiveType(typeId: 0)
class PillModel extends HiveObject {

  @HiveField(0)
  late String name;

  @HiveField(1)
  late String totalNumber;

  @HiveField(2)
  late String dayNumber;

  @HiveField(3)
  late String startDate;

  @HiveField(4)
  late String dayTime;

  @HiveField(5)
  late Map<String, String> dayOfWeekAndTime;
}