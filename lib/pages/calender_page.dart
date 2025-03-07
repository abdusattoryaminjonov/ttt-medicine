import 'dart:convert';

import 'package:TTTMedicine/controllers/calender_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../services/auth_service.dart';
import '../widgets/clip_wawe.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  final controller = Get.find<CalenderController>();
  Map<int, bool> isTakenMap = {};

  @override
  void initState() {
    super.initState();
    controller.loadMedicines();
    if (!controller.isDateLoaded) {
      controller.currentWeekDates =
          controller.getCurrentWeekDates(controller.selectedDate);
      controller.isDateLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<CalenderController>(
      builder: (_) {
        return Stack(
          children: [
            SizedBox(
              height: 200,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: AppColors.appActiveColor,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10, top: 35),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: CachedNetworkImage(
                              height: 70,
                              width: 70,
                              imageUrl: AuthService.currentUser().photoURL!,
                              placeholder: (context, url) => const Image(
                                image:
                                    AssetImage("assets/images/user_icon.jpg"),
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => const Image(
                                image:
                                    AssetImage("assets/images/user_icon.jpg"),
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            height: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hi ${AuthService.currentUser().displayName!.split(' ')[0]}",
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                 Row(
                                   children: [
                                     Text(
                                       "Today you take ",
                                       style: TextStyle(
                                         fontSize: 18,
                                         fontFamily: 'Roboto',
                                         color: AppColors.white100,
                                       ),
                                     ),
                                     Text(
                                       "${controller.todayMedicines.length}",
                                       style: TextStyle(
                                         fontWeight: FontWeight.w900,
                                         fontSize: 18,
                                         fontFamily: 'Roboto',
                                         color: AppColors.white100,
                                       ),
                                     ),
                                     Text(
                                       " pills",
                                       style: TextStyle(
                                         fontSize: 18,
                                         fontFamily: 'Roboto',
                                         color: AppColors.white100,
                                       ),
                                     ),
                                   ],
                                 )

                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10, right: 10),
                          height: 70,
                          child:
                              Stack(alignment: Alignment.topRight, children: [
                            const Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 36,
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.red,
                              ),
                              child: Center(
                                  child: Text(
                                "${controller.todayMedicines.length}",
                                style: TextStyle(color: AppColors.white100),
                              )),
                            ),
                          ]),
                        )
                      ],
                    ),
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat.yMMMM().format(controller.selectedDate),
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.appActiveColor),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: controller.currentWeekDates
                                .map((date) => _buildCalendarDay(date,
                                    selectedDate: controller.selectedDate))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.todayMedicines.length,
                        itemBuilder: (context, index) {
                          var medicine = controller.todayMedicines[index];
                          String title = medicine['name'] ?? 'Unknown';
                          String dose = medicine['dayNumber'] ?? 'No dose';
                          String day = medicine['dayTime'] ?? 'daily';
                          String time = 'Unknown time';

                          // dayOfWeekAndTime ni Map sifatida olish
                          if (medicine['dayOfWeekAndTime'] != null && medicine['dayOfWeekAndTime'] is String) {
                            try {
                              Map<String, dynamic> dayOfWeekAndTime = jsonDecode(medicine['dayOfWeekAndTime']);
                              // Hozirgi kunning vaqtini olish
                              String today = DateFormat('EEEE').format(DateTime.now()); // Masalan: Monday
                              time = dayOfWeekAndTime.values.where((time) => time.isNotEmpty).join(", ");
                            } catch (e) {
                              print("JSON decode error: $e");
                            }
                          }

                          bool isTaken = isTakenMap[index] ?? false; // Standart false

                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: 0.25,
                                children: [
                                  SlidableAction(
                                    onPressed: (BuildContext context) {
                                      setState(() {
                                        isTakenMap[index] = true;
                                      });

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Center(
                                            child: Text(
                                              "$title qabul qilindi!",
                                              style: TextStyle(color: AppColors.white100),
                                            ),
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: AppColors.green,
                                          elevation: 5,
                                        ),
                                      );
                                    },
                                    backgroundColor: AppColors.green,
                                    foregroundColor: AppColors.white100,
                                    icon: Icons.check_circle,
                                    label: 'Take',
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                ],
                              ),
                              child: Container(
                                height: 101,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.white100,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            title,
                                            style: const TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            isTaken ? "Salomat bo'ling!" : "ichish",
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: isTaken ? AppColors.green : AppColors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "$dose pill",
                                        style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 18,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Before meal",
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 15,
                                              color: AppColors.black05,
                                            ),
                                          ),
                                          Text(
                                            "${day} at ${time}",
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 15,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),


                    // Expanded(
                    //    child: ListView.builder(
                    //      itemCount: controller.todayMedicines.length,
                    //      itemBuilder: (context, index) {
                    //        var medicine = controller.todayMedicines[index];
                    //        String title = medicine['name'] ?? 'Unknown';
                    //        String dose = medicine['dayNumber'] ?? 'No dose';
                    //        String time = medicine['dayNumber'] ?? 'Unknown time';
                    //
                    //        return Padding(
                    //          padding: const EdgeInsets.all(10),
                    //          child: Slidable(
                    //            endActionPane: ActionPane(
                    //              motion: const ScrollMotion(),
                    //              extentRatio: 0.25,
                    //              children: [
                    //                SlidableAction(
                    //                  onPressed: (BuildContext context) {
                    //                    ScaffoldMessenger.of(context).showSnackBar(
                    //                      SnackBar(
                    //                        content: Center(child: Text("$title qabul qilindi!",style: TextStyle(color: AppColors.white100),)),
                    //                        behavior: SnackBarBehavior.floating,
                    //                        backgroundColor: AppColors.green,
                    //                        elevation: 5,
                    //                      ),
                    //                    );
                    //                  },
                    //                  backgroundColor: AppColors.green,
                    //                  foregroundColor: AppColors.white100,
                    //                  icon: Icons.check_circle,
                    //                  label: 'Take',
                    //                  borderRadius: const BorderRadius.only(
                    //                    topLeft: Radius.circular(0),
                    //                    bottomLeft: Radius.circular(0),
                    //                    topRight: Radius.circular(10),
                    //                    bottomRight: Radius.circular(10),
                    //                  ),
                    //                ),
                    //              ],
                    //            ),
                    //            child: Container(
                    //              height: 101,
                    //              decoration: BoxDecoration(
                    //                borderRadius: BorderRadius.circular(15),
                    //                color: AppColors.white100,
                    //                boxShadow: [
                    //                  BoxShadow(
                    //                    color: Colors.black.withOpacity(0.2),
                    //                    spreadRadius: 2,
                    //                    blurRadius: 4,
                    //                    offset: const Offset(2, 2),
                    //                  ),
                    //                ],
                    //              ),
                    //              child: Padding(
                    //                padding: const EdgeInsets.all(10),
                    //                child: Column(
                    //                  mainAxisAlignment: MainAxisAlignment.center,
                    //                  crossAxisAlignment: CrossAxisAlignment.start,
                    //                  children: [
                    //                    Row(
                    //                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                      children: [
                    //                        Text(
                    //                          title,
                    //                          style: const TextStyle(
                    //                            fontFamily: 'Roboto',
                    //                            fontWeight: FontWeight.bold,
                    //                            fontSize: 20,
                    //                          ),
                    //                        ),
                    //                        Text(
                    //                          "ichish",
                    //                          style: TextStyle(
                    //                            fontFamily: 'Roboto',
                    //                            fontWeight: FontWeight.bold,
                    //                            fontSize: 20,
                    //                            color: AppColors.red,
                    //                          ),
                    //                        ),
                    //                      ],
                    //                    ),
                    //                    Text(
                    //                      "$dose pill",
                    //                      style: const TextStyle(
                    //                        fontFamily: 'Roboto',
                    //                        fontSize: 18,
                    //                      ),
                    //                    ),
                    //                    Row(
                    //                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                      children: [
                    //                        Text(
                    //                          "Before meal",
                    //                          style: TextStyle(
                    //                            fontFamily: 'Roboto',
                    //                            fontSize: 15,
                    //                            color: AppColors.black05,
                    //                          ),
                    //                        ),
                    //                        Text(
                    //                          "Everyday at $time",
                    //                          style: TextStyle(
                    //                            fontFamily: 'Roboto',
                    //                            fontSize: 15,
                    //                            color: AppColors.black,
                    //                          ),
                    //                        ),
                    //                      ],
                    //                    )
                    //                  ],
                    //                ),
                    //              ),
                    //            ),
                    //          ),
                    //        );
                    //      },
                    //    ),),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ));
  }

  Widget _buildCalendarDay(DateTime date, {required DateTime selectedDate}) {
    bool isToday = DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isToday ? AppColors.appActiveColor : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            DateFormat.E().format(date), // Haftaning kuni (e.g., Mon, Tue)
            style: TextStyle(
              color: isToday ? AppColors.white100 : AppColors.appActiveColor,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            date.day.toString(), // Oy kunining raqami
            style: TextStyle(
              color: isToday ? AppColors.white100 : AppColors.appActiveColor,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
