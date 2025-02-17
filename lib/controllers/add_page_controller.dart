import 'package:TTTMedicine/models/pill_sql_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';

import '../services/sql_service.dart';

class AddPageController extends GetxController{

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController overallNumberTextController = TextEditingController();
  final TextEditingController numberTextController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;
  late GroupButtonController checkboxesController = GroupButtonController();
  late TimeOfDay selectedTime = TimeOfDay.now();


  String dropdownValue = 'xar-kuni';

  List<String> items = [
    'xar-kuni',
    'kun-ora',
  ];

  final Map<String,String> checkboxButtons = {
    'Nonushta': '08:00',
    'Tushlik': '12:00',
    'Kechki ovqat': '18:00',
  };

  Future selectDate(BuildContext context) async => showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1990),
    lastDate: DateTime(2050),
  ).then((DateTime? selected) {
    if (selected != null && selected != selectedDate) {
        selectedDate = selected;
        dateController.text = DateFormat('MM/dd/yyyy').format(selectedDate!);
        update();
    }
  });

  void changeDay(String? value){
      dropdownValue = value!;
      update();
  }

  void onTimeChanged(TimeOfDay time) {
    selectedTime = time;
    update();
  }

  backToPillsPage(){
    Get.back();
  }

  void saveSqlPill() async {
    String name = nameTextController.text;
    String totalNumber = overallNumberTextController.text;
    String dayNumber = numberTextController.text;
    String startDate = dateController.text;

    String dayTime = dropdownValue;

    Map<String, String> dayOfWeekAndTime = {};
    for (var entry in checkboxButtons.entries) {
      if (checkboxesController.selectedIndexes.contains(checkboxButtons.keys.toList().indexOf(entry.key))) {
        dayOfWeekAndTime[entry.key] = entry.value;
      }
    }

    SqlPill sqlPill = SqlPill(
      name: name,
      totalNumber: totalNumber,
      dayNumber: dayNumber,
      startDate: startDate,
      dayTime: dayTime,
      dayOfWeekAndTime: dayOfWeekAndTime,
    );

    await SqlPillDatabase.insertPill(sqlPill);
    update();
    backToPillsPage();

    nameTextController.clear();
    overallNumberTextController.clear();
    numberTextController.clear();
    dateController.clear();
    dropdownValue = 'xar-kuni';
    checkboxesController = GroupButtonController();
  }

  goToBack(){
    Get.back();
  }
}