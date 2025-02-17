import 'dart:convert';

class SqlPill {
  int? id;
  String? name;
  String? totalNumber;
  String? dayNumber;
  String? startDate;
  String? dayTime;
  Map<String, String>? dayOfWeekAndTime;

  SqlPill({
    this.id,
    this.name,
    this.totalNumber,
    this.dayNumber,
    this.startDate,
    this.dayTime,
    this.dayOfWeekAndTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'totalNumber': totalNumber,
      'dayNumber': dayNumber,
      'startDate': startDate,
      'dayTime': dayTime,
      'dayOfWeekAndTime': jsonEncode(dayOfWeekAndTime),
    };
  }

  static SqlPill fromMap(Map<String, dynamic> map) {
    return SqlPill(
      id: map['id'],
      name: map['name'],
      totalNumber: map['totalNumber'],
      dayNumber: map['dayNumber'],
      startDate: map['startDate'],
      dayTime: map['dayTime'],
      dayOfWeekAndTime: map['dayOfWeekAndTime'] != null
          ? Map<String, String>.from(jsonDecode(map['dayOfWeekAndTime']))
          : null,
    );
  }
}
