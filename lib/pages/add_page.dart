import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:group_button/group_button.dart';


import '../constants/app_colors.dart';
import '../widgets/clip_wawe.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();
  late GroupButtonController _checkboxesController = GroupButtonController();
  late TimeOfDay _selectedTime = TimeOfDay.now();


  String dropdownValue = 'xar-kuni';

  List<String> items = [
    'xar-kuni',
    'kun-ora',
  ];

  final Map<String,String> _checkboxButtons = {
    'Nonushta': '08:00',
    'Tushlik': '12:00',
    'Kechki ovqat': '18:00',
  };

  Future _selectDate(BuildContext context) async => showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1990),
    lastDate: DateTime(2050),
  ).then((DateTime? selected) {
    if (selected != null && selected != _selectedDate) {
      setState(() {
        _selectedDate = selected;
        _dateController.text = DateFormat('MM/dd/yyyy').format(_selectedDate!);
      });
    }
  });

  void changeDay(String? value){
    setState(() {
      dropdownValue = value!;
    });
  }

  void _onTimeChanged(TimeOfDay time) {
    setState(() {
      _selectedTime = time;
    });
  }



  @override
  void initState() {
    super.initState();

    _checkboxesController = GroupButtonController(
      selectedIndexes: [2],
      disabledIndexes: [4],
      onDisablePressed: (index) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_checkboxButtons[index]} is disabled')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height:200,
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
                  Container(
                    padding: const EdgeInsets.only(left: 20,top: 10),
                    height: 150,
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("New Medicine",style:TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white100,
                        ),),
                        Text("for health",style:TextStyle(
                          fontSize: 10,
                          fontFamily: 'Roboto',
                          color: AppColors.white100,
                        ),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
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
                                  margin: const EdgeInsets.only(top: 4,bottom: 14),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(21),
                                    border: Border.all(
                                        color: AppColors.appActiveColor,
                                        width: 1),
                                  ),
                                  child:  TextField(
                                    // controller:loginController.emailController,
                                    style: TextStyle(
                                      color: AppColors.black,),
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
                                      margin: const EdgeInsets.only(top: 4,bottom: 14),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(21),
                                        border: Border.all(
                                            color: AppColors.appActiveColor,
                                            width: 1),
                                      ),
                                      child:  TextField(
                                        // controller:loginController.emailController,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          color: AppColors.black,),
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
                              const SizedBox(width: 10,),
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
                                      margin: const EdgeInsets.only(top: 4,bottom: 14),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(21),
                                        border: Border.all(
                                            color: AppColors.appActiveColor,
                                            width: 1),
                                      ),
                                      child: TextField(
                                        // controller:loginController.emailController,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          color: AppColors.black,),
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
                          const SizedBox(width: 5,),
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
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(21),
                                        border: Border.all(
                                            color: AppColors.appActiveColor,
                                            width: 1),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: _dateController,
                                              style: TextStyle(color: AppColors.black),
                                              textAlign: TextAlign.start,
                                              decoration:  InputDecoration(
                                                  hintText: 'mm/dd/yyyy',
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      fontSize: 15, color: AppColors.black)),
                                              readOnly: true,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => _selectDate(context),
                                            child: Icon(Icons.date_range,color: AppColors.black,),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10,),
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
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                          value: dropdownValue,
                                          icon:  Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: AppColors.black,
                                          ),
                                          iconSize: 24,
                                          elevation: 15,
                                          style:  TextStyle(
                                              color: AppColors.black),
                                          onChanged: (String? newValue) {
                                            changeDay(newValue);
                                          },
                                          items: items
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
                          const SizedBox(width: 15,),
                          GroupButton(
                            controller: _checkboxesController,
                            isRadio: false,
                            options: const GroupButtonOptions(
                              groupingType: GroupingType.column,
                            ),
                            buttons: _checkboxButtons.keys.toList(), // Faqat kalitlar ro'yxati
                            buttonIndexedBuilder: (selected, index, context) {
                              String title = _checkboxButtons.keys.elementAt(index);
                              String initialTime = _checkboxButtons[title]!;

                              return Row(
                                children: [
                                  Expanded(
                                    child: CheckBoxTile(
                                      title: title,
                                      selected: selected,
                                      onTap: () {
                                        if (!selected) {
                                          _checkboxesController.selectIndex(index);
                                          return;
                                        }
                                        _checkboxesController.unselectIndex(index);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        // Vaqtni TimeOfDay formatiga o'tkazish
                                        List<String> timeParts = initialTime.split(':');
                                        TimeOfDay defaultTime = TimeOfDay(
                                          hour: int.parse(timeParts[0]),
                                          minute: int.parse(timeParts[1]),
                                        );

                                        TimeOfDay? pickedTime = await showTimePicker(
                                          context: context,
                                          initialTime: defaultTime,
                                        );

                                        if (pickedTime != null && '${pickedTime.hour}:${pickedTime.minute}' != initialTime) {
                                          _checkboxButtons[title] =
                                          '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                                          debugPrint(
                                              'Button: $title updated time: ${pickedTime.format(context)}');
                                        }
                                      },
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
                  const SizedBox(height: 50,)
                ],
              ),
            ),
          )
        ],
      ),
    );

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
