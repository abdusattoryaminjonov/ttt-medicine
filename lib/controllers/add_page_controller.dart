import 'package:TTTMedicine/models/pill_sql_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';
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

  Future<void> saveSqlPill(BuildContext context) async {
    if (nameTextController.text.isEmpty ||
        overallNumberTextController.text.isEmpty ||
        numberTextController.text.isEmpty ||
        dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Barcha maydonlarni to'ldiring!")),
      );
      return;
    }

    final Map<String, String> selectedCheckboxes = {};
    for (var entry in checkboxButtons.entries) {
      bool isSelected = checkboxesController.selectedIndexes.contains(
        checkboxButtons.keys.toList().indexOf(entry.key),
      );
      selectedCheckboxes[entry.key] = isSelected ? entry.value : '';
    }
    var consumptionDayNumber = double.parse(overallNumberTextController.text) / double.parse(numberTextController.text) ;
    int day = consumptionDayNumber.toInt();

    final sqlPill = SqlPill(
      name: nameTextController.text,
      totalNumber: overallNumberTextController.text,
      dayNumber: numberTextController.text,
      startDate: dateController.text,
      consumptionDay: day.toString(),
      dayTime: dropdownValue,
      dayOfWeekAndTime: selectedCheckboxes,
    );

    await SqlPillDatabase.insertPill(sqlPill);
    update();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            "Ma'lumotlar saqlandi!",
            style: TextStyle(color: AppColors.white100),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.green,
        elevation: 5,
      ),
    );


    nameTextController.clear();
    overallNumberTextController.clear();
    numberTextController.clear();
    dateController.clear();
    consumptionDayNumber = 0;
    dropdownValue = 'xar-kuni';
    checkboxesController = GroupButtonController();

    await scheduleAlarms(selectedCheckboxes, day);
    await initializeNotifications();

    backToPillsPage();
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// **1. Bildirishnomalarni sozlash**
  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleAlarms(Map<String, String> selectedCheckboxes, int day) async {
    final now = DateTime.now();
    for (int i = 0; i < day; i++) {
      for (var entry in selectedCheckboxes.entries) {
        if (entry.value.isNotEmpty) {
          final timeParts = entry.value.split(':');
          final hour = int.parse(timeParts[0]);
          final minute = int.parse(timeParts[1]);

          final alarmTime = tz.TZDateTime(
              tz.local, now.year, now.month, now.day + i, hour, minute
          );

          await flutterLocalNotificationsPlugin.zonedSchedule(
            i * 100 + hour * 60 + minute,
            'Dori eslatmasi',
            'Belgilangan vaqtda dorini ichishni unutmang!',
            alarmTime,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'alarm_channel',
                'Alarm Channel',
                channelDescription: 'Dori ichish uchun eslatma',
                importance: Importance.max,
                priority: Priority.high,
                sound: RawResourceAndroidNotificationSound('alarm_sound'),
                playSound: true,
              ),
            ),
            uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
            matchDateTimeComponents: DateTimeComponents.time,
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          );
        }
      }
    }
  }
}