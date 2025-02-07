import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/main.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/res/const_files/text_const.dart';

class BreakHistory extends StatefulWidget {
  const BreakHistory({super.key});

  @override
  State<BreakHistory> createState() => _BreakHistoryState();
}

class _BreakHistoryState extends State<BreakHistory> {
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
          title: "Break History",
          fontWeight: FontWeight.bold,
          fontSize: textFontSize20,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          spaceHeight10,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Break History ${_selectedDate != null ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}" : "Select Date"} ",
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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Card(
                  color: AppColor.white10,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: TextConst(
                      textAlign: TextAlign.start,
                      title: "Date & Time :- 12-12-25",
                      color: AppColor.blackTemp,
                      fontWeight: FontWeight.bold,
                      fontSize: textFontSize17,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextConst(
                          textAlign: TextAlign.start,
                          title: "Break Start :-",
                          fontSize: textFontSize15,
                          color: AppColor.blackTemp,
                        ),
                        TextConst(
                          textAlign: TextAlign.start,
                          title: "Break End :-",
                          fontSize: textFontSize15,
                          color: AppColor.blackTemp,
                        ),
                        TextConst(
                          textAlign: TextAlign.start,
                          title: "Break Purpose :-",
                          fontSize: textFontSize15,
                          color: AppColor.blackTemp,
                        ),
                        TextConst(
                          textAlign: TextAlign.start,
                          title: "Break Approved By :-",
                          fontSize: textFontSize15,
                          fontWeight: FontWeight.bold,
                          color: AppColor.blackTemp,
                        ),
                      ],
                    ),
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
