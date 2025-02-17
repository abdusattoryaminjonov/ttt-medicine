import 'package:TTTMedicine/controllers/pills_controller.dart';
import 'package:TTTMedicine/models/pill_sql_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../widgets/clip_wawe.dart';

class PillsPage extends StatefulWidget {
  static const String id = 'pills_page';
  const PillsPage({super.key});

  @override
  State<PillsPage> createState() => _PillsPageState();
}

class _PillsPageState extends State<PillsPage> {
  final controller = Get.find<PillsController>();

  @override
  void initState() {
    super.initState();
    controller.loadPills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<PillsController>(builder: (_) {
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: (){
                                    controller.callAddPage();
                                  },
                                  icon: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.white100,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.add,
                                      size: 30,
                                      color: AppColors.appActiveColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    "New Medicine",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.white100,
                                    ),
                                  ),
                                  Text(
                                    "for health",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Roboto',
                                      color: AppColors.white100,
                                    ),
                                  ),
                                  // MaterialButton(
                                  //   color: AppColors.white100,
                                  //   onPressed: (){},
                                  //   child: Container(
                                  //     width: 80,
                                  //     height: 40,
                                  //     child: Row(
                                  //       mainAxisAlignment: MainAxisAlignment.center,
                                  //       children: [
                                  //         Icon(
                                  //           Icons.medication,color: AppColors.appActiveColor,
                                  //         ),
                                  //         Text("add",style: TextStyle(color: AppColors.appActiveColor,fontSize: 20))
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.sqlPills.length,
                      itemBuilder: (ctx, i) {
                        return _itemSqlPillList(controller.sqlPills[i]);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          )
        ],
      );
    }));
  }

  Widget _itemSqlPillList(SqlPill sqlPill) {
    return GestureDetector(
      onLongPress: () {
        // print(typeDatabase);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(5),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Text('${sqlPill.name}'),
          ],
        ),
      ),
    );
  }
}
