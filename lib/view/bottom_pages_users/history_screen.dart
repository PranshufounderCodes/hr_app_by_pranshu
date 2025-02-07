import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/main.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/res/const_files/text_const.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime? _selectedDate;

  void _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primary,
        title: const TextConst(
          title: "Punch History",
          fontWeight: FontWeight.bold,
          fontSize: textFontSize20,
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceHeight10,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Attendance History ${_selectedDate != null ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}" : "Select Date"} ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: textFontSize17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                    onTap: () => _pickDate(context),
                    child:
                        const Icon(Icons.calendar_month, color: AppColor.red))
              ],
            ),
          ),
          spaceHeight10,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: const TextConst(
              textAlign: TextAlign.start,
              title: "Total Present Day :- 365/222",
              color: AppColor.primary,
              fontWeight: FontWeight.bold,
              fontSize: textFontSize17,
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                return  Card(
                  color: AppColor.white10,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: const TextConst(
                      textAlign: TextAlign.start,
                      title: "Date & Time :- 12-12-25",
                      color: AppColor.blackTemp,
                      fontWeight: FontWeight.bold,
                      fontSize: textFontSize17,
                    ),
                    subtitle: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextConst(
                          textAlign: TextAlign.start,
                          title: "Punch In :-",
                          fontSize: textFontSize15,
                          color: AppColor.blackTemp,
                        ),
                        TextConst(
                          textAlign: TextAlign.start,
                          title: "Punch Out :-",
                          fontSize: textFontSize15,
                          color: AppColor.blackTemp,
                        ),TextConst(
                          textAlign: TextAlign.start,
                          title: "Duration :-",
                          fontSize: textFontSize15,
                          color: AppColor.blackTemp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],

                    ),
                    trailing: Container(
                        alignment: Alignment.center,
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.1,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.green.shade300,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const TextConst(
                          textAlign: TextAlign.start,
                          fontSize: textFontSize20,
                          title:
                          "P" ,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
