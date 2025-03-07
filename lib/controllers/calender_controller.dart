import 'package:TTTMedicine/services/sql_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalenderController extends GetxController{

  final checkController = ValueNotifier<bool>(false);
  late final List<DateTime> currentWeekDates;
  final DateTime selectedDate = DateTime.now();

  bool checked = false;
  bool isDateLoaded = false;

  List<Map<String, dynamic>> todayMedicines = [];

  List<DateTime> getCurrentWeekDates(DateTime selectedDate) {
    final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  Future<List<Map<String, dynamic>>> getMedicines() async {
    final db = await SqlPillDatabase.instance.database;
    final result = await db.query('pills', where: 'consumptionDay > ?', whereArgs: [0]);

    return result;
  }

  Future<void> loadMedicines() async {
    List<Map<String, dynamic>> meds = await getMedicines();
    todayMedicines = meds;
    update();
  }

}