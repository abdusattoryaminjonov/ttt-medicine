import 'package:TTTMedicine/controllers/pills_controller.dart';
import 'package:TTTMedicine/models/pill_sql_model.dart';
import 'package:TTTMedicine/services/sql_service.dart';
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: (){
                                    controller.loadPills();
                                  },
                                  icon: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.white100,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.refresh,
                                      size: 25,
                                      color: AppColors.appActiveColor,
                                    ),
                                  ),
                                ),
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
                                      size: 25,
                                      color: AppColors.appActiveColor,
                                    ),
                                  ),
                                ),
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
      onTap: () {
        controller.showPillDetailsDialog(context, sqlPill);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.blueWhite,
        ),
        child:  Padding(
          padding: const EdgeInsets.only(left: 20,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text("${sqlPill.name}",style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit,color: AppColors.green,),
                        onPressed: (){},
                      ),
                      IconButton(
                        icon: Icon(Icons.delete,color: AppColors.red,),
                        onPressed: (){
                          SqlPillDatabase.deletePill(sqlPill.id!.toInt());
                          controller.loadPills();
                        },
                      ),
                    ],
                  )
                ],
              ),
              Text("Dori ${sqlPill.consumptionDay} kunlik qoldi",style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
              ),),

            ],
          ),
        ),
      ),
    );
  }
}
