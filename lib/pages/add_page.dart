import 'package:TTTMedicine/controllers/add_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../constants/app_colors.dart';
import '../widgets/clip_wawe.dart';

class AddPage extends StatefulWidget {
  static const String id = 'add_page';
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final controller = Get.find<AddPageController>();

  @override
  void initState() {
    super.initState();

    controller.checkboxesController = GroupButtonController(
      selectedIndexes: [2],
      disabledIndexes: [4],
      onDisablePressed: (index) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('${controller.checkboxButtons[index]} is disabled')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<AddPageController>(builder: (_) {
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
                              children: [
                                IconButton(
                                  onPressed: () {
                                    controller.backToPillsPage();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_outlined,
                                    color: AppColors.white100,
                                    size: 30,
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dori nomi",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.appActiveColor,
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 4, bottom: 14),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(21),
                                    border: Border.all(
                                        color: AppColors.appActiveColor,
                                        width: 1),
                                  ),
                                  child: TextField(
                                    controller: controller.nameTextController,
                                    style: TextStyle(
                                      color: AppColors.black,
                                    ),
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                        hintText: "nomi",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.black)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Umumiy son",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.appActiveColor,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 4, bottom: 14),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(21),
                                        border: Border.all(
                                            color: AppColors.appActiveColor,
                                            width: 1),
                                      ),
                                      child: TextField(
                                        controller: controller
                                            .overallNumberTextController,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          color: AppColors.black,
                                        ),
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                            hintText: "soni",
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                fontSize: 15,
                                                color: AppColors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Kunlik son",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.appActiveColor,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 4, bottom: 14),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(21),
                                        border: Border.all(
                                            color: AppColors.appActiveColor,
                                            width: 1),
                                      ),
                                      child: TextField(
                                        controller:
                                            controller.numberTextController,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          color: AppColors.black,
                                        ),
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                            hintText: "soni",
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                fontSize: 15,
                                                color: AppColors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Qabul qilish kuni(boshlash)",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.appActiveColor,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(21),
                                        border: Border.all(
                                            color: AppColors.appActiveColor,
                                            width: 1),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller:
                                                  controller.dateController,
                                              style: TextStyle(
                                                  color: AppColors.black),
                                              textAlign: TextAlign.start,
                                              decoration: InputDecoration(
                                                  hintText: 'mm/dd/yyyy',
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      fontSize: 15,
                                                      color: AppColors.black)),
                                              readOnly: true,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                controller.selectDate(context),
                                            child: Icon(
                                              Icons.date_range,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Kun",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.appActiveColor,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(21),
                                        border: Border.all(
                                            color: AppColors.appActiveColor,
                                            width: 1),
                                      ),
                                      child: SizedBox(
                                        child: DropdownButtonFormField<String>(
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          value: controller.dropdownValue,
                                          icon: Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: AppColors.black,
                                          ),
                                          iconSize: 24,
                                          elevation: 15,
                                          style:
                                              TextStyle(color: AppColors.black),
                                          onChanged: (String? newValue) {
                                            controller.changeDay(newValue);
                                          },
                                          items: controller.items
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          GroupButton(
                            controller: controller.checkboxesController,
                            isRadio: false,
                            options: const GroupButtonOptions(
                              groupingType: GroupingType.column,
                            ),
                            buttons: controller.checkboxButtons.keys
                                .toList(), // Faqat kalitlar ro'yxati
                            buttonIndexedBuilder: (selected, index, context) {
                              String title = controller.checkboxButtons.keys
                                  .elementAt(index);
                              String initialTime =
                                  controller.checkboxButtons[title]!;

                              return Row(
                                children: [
                                  Expanded(
                                    child: CheckBoxTile(
                                      title: title,
                                      selected: selected,
                                      onTap: () {
                                        if (!selected) {
                                          controller.checkboxesController
                                              .selectIndex(index);
                                          return;
                                        }
                                        controller.checkboxesController
                                            .unselectIndex(index);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                            DateTime.parse(
                                                '2024-01-01 ${initialTime}:00'),
                                          ),
                                        );

                                        if (pickedTime != null) {
                                          setState(() {
                                            controller.checkboxButtons[title] =
                                                '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                          });
                                        }
                                      },
                                      //   // Vaqtni TimeOfDay formatiga o'tkazish
                                      //   List<String> timeParts = initialTime.split(':');
                                      //   TimeOfDay defaultTime = TimeOfDay(
                                      //     hour: int.parse(timeParts[0]),
                                      //     minute: int.parse(timeParts[1]),
                                      //   );
                                      //
                                      //   TimeOfDay? pickedTime = await showTimePicker(
                                      //     context: context,
                                      //     initialTime: defaultTime,
                                      //   );
                                      //
                                      //   if (pickedTime != null && '${pickedTime.hour}:${pickedTime.minute}' != initialTime) {
                                      //     controller.checkboxButtons[title] =
                                      //     '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                      //     debugPrint(
                                      //         'Button: $title updated time: ${pickedTime.format(context)}');
                                      //   }
                                      // },
                                      child: Text(
                                        initialTime, // Tugma ustida vaqtni ko'rsatadi
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            onSelected: (val, i, selected) =>
                                debugPrint('Button: $val index: $i $selected'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Card(
                      color: AppColors.appActiveColor,
                      elevation: 5,
                      child: ListTile(
                        title: Center(
                          child: Text("Qo'shish",
                              style: TextStyle(
                                  color: AppColors.white100,
                                  fontWeight: FontWeight.bold)),
                        ),
                        onTap: () {
                          controller.saveSqlPill(context);
                        },
                      ),
                    ),
                  ),

                  // const SizedBox(height: 50,)
                ],
              ),
            ),
          )
        ],
      );
    }));
  }
}

class CheckBoxTile extends StatelessWidget {
  const CheckBoxTile({
    Key? key,
    required this.selected,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
      leading: Checkbox(
        value: selected,
        onChanged: (val) {
          onTap();
        },
      ),
    );
  }
}
