import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../widgets/clip_wawe.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage>{

  final _checkController = ValueNotifier<bool>(false);
  DateTime selectedDate = DateTime.now();

  bool _checked = false;

  List<DateTime> getCurrentWeekDates(DateTime selectedDate) {
    final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  void initState() {
    super.initState();

    _checkController.addListener(() {
      setState(() {
        if (_checkController.value) {
          _checked = true;
        } else {
          _checked = false;
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final currentWeekDates = getCurrentWeekDates(selectedDate);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height:200,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: Colors.deepPurpleAccent,
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
                        margin: const EdgeInsets.only(left: 10,top: 35),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: const Image(
                              image: AssetImage("assets/images/myphoto.jpg"),
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 20,top: 10),
                          height: 70,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hi Abdusattor",style:TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),),
                              Text("Today you take 3pills",style:TextStyle(
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                color: Colors.white,
                              ),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10,right: 10),
                        height: 70,
                        child:  Stack(
                          alignment: Alignment.topRight,
                          children: [
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
                                color: Colors.red,
                              ),
                              child: const Center(child: Text("3",style: TextStyle(color: Colors.white),)),
                            ),
                          ]
                        ),
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
                          DateFormat.yMMMM().format(selectedDate),
                          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: currentWeekDates
                              .map(
                                (date) => Container(
                              width: 40.0,
                              alignment: Alignment.center,
                              child: Text(
                                DateFormat('E', 'en_US').format(date),
                                style: const TextStyle(fontSize: 14.0, color: Colors.deepPurpleAccent),
                              ),
                            ),
                          )
                              .toList(),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: currentWeekDates
                              .map((date) => _buildCalendarDay(date, selectedDate: selectedDate))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: 0.25,
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext context) {
                                        // _deletePost(post);
                                      },
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
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
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),  // Shadow color with some opacity
                                        spreadRadius: 2,  // Spread radius
                                        blurRadius: 4,   // Blur radius
                                        offset: const Offset(2, 2),  // Offset of the shadow
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
                                            const Text("Title 500gr",style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),),
                                            AdvancedSwitch(
                                              controller: _checkController,
                                              activeColor: Colors.deepPurpleAccent,
                                            ),
                                          ],
                                        ),
                                        const Text("1pill",style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 18,
                                        ),),
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Before meal",style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 15,
                                              color: Colors.black38
                                            ),),
                                            Text("Everyday at 8:00 am",style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 15,
                                              color: Colors.black
                                            ),),
                                          ],
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14,),
                              Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: 0.25,
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext context) {
                                        // _deletePost(post);
                                      },
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
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
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),  // Shadow color with some opacity
                                        spreadRadius: 2,  // Spread radius
                                        blurRadius: 4,   // Blur radius
                                        offset: const Offset(2, 2),  // Offset of the shadow
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
                                            const Text("Title 500gr",style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),),
                                            AdvancedSwitch(
                                              controller: _checkController,
                                              activeColor: Colors.deepPurpleAccent,
                                            ),
                                          ],
                                        ),
                                        const Text("1pill",style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 18,
                                        ),),
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Before meal",style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 15,
                                                color: Colors.black38
                                            ),),
                                            Text("Everyday at 8:00 am",style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 15,
                                                color: Colors.black
                                            ),),
                                          ],
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildCalendarDay(DateTime date, {required DateTime selectedDate}) {
    final isSelected = date.day == selectedDate.day;
    return SizedBox(
      width: 40.0,
      height: 40.0,
      child: Center(
        child: Text(
          '${date.day}',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.deepPurpleAccent,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}


