import 'package:TTTMedicine/constants/app_colors.dart';
import 'package:TTTMedicine/models/pill_sql_model.dart';
import 'package:TTTMedicine/services/sql_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PillsController extends GetxController{

  List<SqlPill> sqlPills = [];

  loadPills() async{
    var myPills = await SqlPillDatabase.getPills();
    sqlPills = myPills;
    update();
  }

  void showPillDetailsDialog(BuildContext context, SqlPill sqlPill) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Map<String, String>? dayOfWeekAndTime ni formatlash
        String formattedDaysAndTimes = '';
        if (sqlPill.dayOfWeekAndTime != null && sqlPill.dayOfWeekAndTime!.isNotEmpty) {
          formattedDaysAndTimes = sqlPill.dayOfWeekAndTime!.entries
              .map((e) => '${e.key}: \t${ e.value.isEmpty ? "yo'q": e.value}')
              .join('\n');
        } else {
          formattedDaysAndTimes = 'No data available';
        }

        return AlertDialog(
          title: Text(sqlPill.name ?? "Medicine"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text("Total Number: \t",style: TextStyle(fontSize: 18),),
                  Text("${sqlPill.totalNumber}",style: TextStyle(fontSize: 18,color: AppColors.appActiveColor),),
                ],
              ),
              Row(
                children: [
                  const Text("Day number: \t",style: TextStyle(fontSize: 18),),
                  Text("${sqlPill.dayNumber}",style: TextStyle(fontSize: 18,color: AppColors.appActiveColor),),
                ],
              ),
              Row(
                children: [
                  const Text("Day Time: \t",style: TextStyle(fontSize: 18),),
                  Text("${sqlPill.dayTime}",style: TextStyle(fontSize: 18,color: AppColors.appActiveColor),),
                ],
              ),
              Row(
                children: [
                  const Text("Start Date: \t",style: TextStyle(fontSize: 18),),
                  Text("${sqlPill.startDate}",style: TextStyle(fontSize: 18,color: AppColors.appActiveColor),),
                ],
              ),

              const SizedBox(height: 10),
              Text("$formattedDaysAndTimes",style: TextStyle(fontSize: 18),),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  callAddPage(){
    Get.toNamed('add_page');
  }

}