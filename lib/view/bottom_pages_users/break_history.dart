import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/main.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/res/const_files/text_const.dart';
import 'package:founder_code_hr_app/view_model/break_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BreakHistory extends StatefulWidget {
  const BreakHistory({super.key});

  @override
  State<BreakHistory> createState() => _BreakHistoryState();
}

class _BreakHistoryState extends State<BreakHistory> {
  DateTime selectedDate = DateTime.now();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final breakViewModel = Provider.of<BreakProvider>(context, listen: false);
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      breakViewModel.breakHistoryApi(context, formattedDate).then((_) {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  void _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        isLoading = true;
      });

      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      print(formattedDate);

      final breakViewModel = Provider.of<BreakProvider>(context, listen: false);
      breakViewModel.breakHistoryApi(context, formattedDate).then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final breakViewModel = Provider.of<BreakProvider>(context);

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
                  "Break History ${DateFormat('dd/MM/yyyy').format(selectedDate)}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: textFontSize17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => _pickDate(context),
                  child: const Icon(Icons.calendar_month, color: AppColor.red),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: AppColor.primary,
                  ))
                : (breakViewModel.breakHistoryModelData?.breakHistoryData ==
                            null ||
                        breakViewModel
                            .breakHistoryModelData!.breakHistoryData!.isEmpty)
                    ? const Center(
                        child: Text(
                          "No Data Available",
                          style: TextStyle(
                              fontSize: textFontSize17,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: breakViewModel
                            .breakHistoryModelData!.breakHistoryData!.length,
                        itemBuilder: (context, index) {
                          final breakView = breakViewModel
                              .breakHistoryModelData!.breakHistoryData![index];
                          return Card(
                            color: AppColor.white10,
                            margin: const EdgeInsets.all(8),
                            child: ListTile(
                              title: TextConst(
                                textAlign: TextAlign.start,
                                title:
                                    "Date & Time :- ${breakView.createdAt != null ? DateFormat('dd-MM-yyyy').format(DateTime.parse(breakView.createdAt!)) : "N/A"}",
                                color: AppColor.blackTemp,
                                fontWeight: FontWeight.bold,
                                fontSize: textFontSize17,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextConst(
                                    textAlign: TextAlign.start,
                                    title:
                                        "Break Start :- ${breakView.breakStartTime ?? "N/A"}",
                                    fontSize: textFontSize15,
                                    color: AppColor.blackTemp,
                                  ),
                                  TextConst(
                                    textAlign: TextAlign.start,
                                    title:
                                        "Break End :- ${breakView.breakEndTime ?? "N/A"}",
                                    fontSize: textFontSize15,
                                    color: AppColor.blackTemp,
                                  ),
                                  TextConst(
                                    textAlign: TextAlign.start,
                                    title:
                                        "Break Purpose :- ${breakView.breakPurpose ?? "N/A"}",
                                    fontSize: textFontSize15,
                                    color: AppColor.blackTemp,
                                  ),
                                  TextConst(
                                    textAlign: TextAlign.start,
                                    title:
                                        "Break Approved By :- ${breakView.approvedBy ?? "N/A"}",
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
