import 'dart:async';
import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/main.dart';
import 'package:founder_code_hr_app/res/const_files/app_btn.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/res/const_files/text_const.dart';
import 'package:founder_code_hr_app/utils/routes/routes_name.dart';
import 'package:founder_code_hr_app/utils/sneck_bar.dart';
import 'package:founder_code_hr_app/view_model/break_view_model.dart';
import 'package:founder_code_hr_app/view_model/location_view_model.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BreakPage extends StatefulWidget {
  const BreakPage({super.key});

  @override
  BreakPageState createState() => BreakPageState();
}

class BreakPageState extends State<BreakPage> {
  final TextEditingController _purposeController = TextEditingController();
  String? selectedApprover; // Dropdown selected value
  Timer? _timer;
  int elapsedSeconds = 0;

  List<String> approvers = ["Manager", "HR", "Team Lead"];

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    final locationProvider = Provider.of<LocationProvider>(context);
    final breakProvider = Provider.of<BreakProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primary,
        leadingWidth: screenWidth,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextConst(
                title: "Break Attendance",
                fontWeight: FontWeight.bold,
                fontSize: textFontSize20,
                color: Colors.white,
              ),
              ButtonConst(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.breakHistory);
                },
                width: screenWidth * 0.2,
                height: screenHeight * 0.04,
                fontSize: textFontSize10,
                color: AppColor.babyPink,
                label: "Break History",
                textColor: AppColor.blackTemp,
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextConst(
              title: "CurrentDate: $currentDate",
              fontSize: textFontSize15,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            Center(
              child: TextConst(
                title:
                    breakProvider.isOnBreak ? "🟢 On Break" : "🔴 Not on Break",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: breakProvider.isOnBreak ? Colors.green : Colors.red,
              ),
            ),

            if (!breakProvider.isOnBreak)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _purposeController,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Break Purpose",
                    ),
                  ),
                ),
              ),

            spaceHeight15,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoTile("Break Start", breakProvider.breakStartTime),
                _infoTile("Break End", breakProvider.breakEndTime),
              ],
            ),

            spaceHeight15,

            // Timer Display
            _infoTile("Break Duration", _formatDuration(elapsedSeconds)),

            spaceHeight15,
            if (breakProvider.isOnBreak)
              _infoTile("Break Purpose", breakProvider.breakPurpose),

            spaceHeight10,

            InkWell(
              onTap: () {
                _showApproverPopup(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextConst(
                    title: selectedApprover ?? "Approved By",
                    color: AppColor.blackTemp,
                    fontWeight: FontWeight.bold,
                  ),
                  const Icon(Icons.arrow_drop_down, color: AppColor.blackTemp),
                ],
              ),
            ),

            const Spacer(),

            if (locationProvider.isProcessing)
              const CircularProgressIndicator(color: AppColor.primary),

            if (!locationProvider.hasPunchedIn &&
                !locationProvider.isProcessing)
              ButtonConst(
                onTap: () {
                  if (locationProvider.isInRange) {
                    if (breakProvider.isOnBreak) {
                      _stopTimer();
                      breakProvider.endBreak();
                      _purposeController.clear();
                    } else {
                      if (_purposeController.text.isNotEmpty &&
                          selectedApprover != null) {
                        _startTimer();
                        breakProvider.startBreak(_purposeController.text);
                      } else {
                        showCustomSnackBar(
                          selectedApprover == null
                              ? "Please select an approver!"
                              : "Please enter a break purpose!",
                          context,
                        );
                      }
                    }
                  }
                },
                color: locationProvider.isInRange
                    ? breakProvider.isOnBreak
                        ? Colors.red
                        : Colors.green
                    : Colors.grey,
                label: breakProvider.isOnBreak ? "End Break" : "Start Break",
              ),

          ],
        ),
      ),
    );
  }

  void _startTimer() {
    setState(() {
      elapsedSeconds = 0;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        elapsedSeconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {});
  }

  String _formatDuration(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$secs";
  }

  Widget _infoTile(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextConst(title: title, fontSize: 16, fontWeight: FontWeight.w500),
        TextConst(title: value, fontSize: 18, fontWeight: FontWeight.bold),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _purposeController.dispose();
    super.dispose();
  }

  void _showApproverPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Approver"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: approvers.map((approver) {
              return ListTile(
                title: Text(approver),
                onTap: () {
                  setState(() {
                    selectedApprover = approver;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

//
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:founder_code_hr_app/main.dart';
// import 'package:founder_code_hr_app/res/const_files/app_btn.dart';
// import 'package:founder_code_hr_app/res/const_files/app_const.dart';
// import 'package:founder_code_hr_app/res/const_files/color_const.dart';
// import 'package:founder_code_hr_app/res/const_files/text_const.dart';
// import 'package:founder_code_hr_app/utils/routes/routes_name.dart';
// import 'package:founder_code_hr_app/utils/sneck_bar.dart';
// import 'package:founder_code_hr_app/view_model/break_view_model.dart';
// import 'package:founder_code_hr_app/view_model/location_view_model.dart';
//
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
//
// class BreakPage extends StatefulWidget {
//   const BreakPage({super.key});
//
//   @override
//   BreakPageState createState() => BreakPageState();
// }
//
// class BreakPageState extends State<BreakPage> {
//   final TextEditingController _purposeController = TextEditingController();
//   String? selectedApprover; // Dropdown selected value
//   Timer? _timer;
//   int elapsedSeconds = 0;
//
//   List<String> approvers = ["Manager", "HR", "Team Lead"];
//
//   @override
//   Widget build(BuildContext context) {
//     String currentDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
//     final locationProvider = Provider.of<LocationProvider>(context);
//     final breakProvider = Provider.of<BreakProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: AppColor.primary,
//         leadingWidth: screenWidth,
//         leading: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const TextConst(
//                 title: "Break Attendance",
//                 fontWeight: FontWeight.bold,
//                 fontSize: textFontSize20,
//                 color: Colors.white,
//               ),
//               ButtonConst(
//                 onTap: () {
//                   Navigator.pushNamed(context, RoutesName.breakHistory);
//                 },
//                 width: screenWidth * 0.2,
//                 height: screenHeight * 0.04,
//                 fontSize: textFontSize10,
//                 color: AppColor.babyPink,
//                 label: "Break History",
//                 textColor: AppColor.blackTemp,
//               )
//             ],
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextConst(
//                 title: "CurrentDate: $currentDate",
//                 fontSize: textFontSize15,
//                 fontWeight: FontWeight.bold,
//               ),
//               const SizedBox(height: 20),
//               Center(
//                 child: TextConst(
//                   title:
//                   breakProvider.isOnBreak ? "🟢 On Break" : "🔴 Not on Break",
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: breakProvider.isOnBreak ? Colors.green : Colors.red,
//                 ),
//               ),
//
//               if (!breakProvider.isOnBreak)
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 5,
//                   ),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.blue),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: _purposeController,
//                     maxLines: 3,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: "Break Purpose",
//                     ),
//                   ),
//                 ),
//
//               spaceHeight15,
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _infoTile("Break Start", breakProvider.breakStartTime),
//                   _infoTile("Break End", breakProvider.breakEndTime),
//                 ],
//               ),
//
//               spaceHeight15,
//
//               // Timer Display
//               _infoTile("Break Duration", _formatDuration(elapsedSeconds)),
//
//               spaceHeight15,
//               if (breakProvider.isOnBreak)
//                 _infoTile("Break Purpose", breakProvider.breakPurpose),
//
//               spaceHeight10,
//
//               InkWell(
//                 onTap: () {
//                   _showApproverPopup(context);
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextConst(
//                       title: selectedApprover ?? "Approved By",
//                       color: AppColor.blackTemp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     const Icon(Icons.arrow_drop_down, color: AppColor.blackTemp),
//                   ],
//                 ),
//               ),
//               spaceHeight50,
//               if (locationProvider.isProcessing)
//                 const CircularProgressIndicator(color: AppColor.primary),
//
//               if (!locationProvider.hasPunchedIn &&
//                   !locationProvider.isProcessing)
//                 ButtonConst(
//                   onTap: () {
//                     if (locationProvider.isInRange) {
//                       if (breakProvider.isOnBreak) {
//                         _stopTimer();
//                         breakProvider.endBreak();
//                         _purposeController.clear();
//                       } else {
//                         if (_purposeController.text.isNotEmpty &&
//                             selectedApprover != null) {
//                           _startTimer();
//                           breakProvider.startBreak(_purposeController.text);
//                         } else {
//                           showCustomSnackBar(
//                             selectedApprover == null
//                                 ? "Please select an approver!"
//                                 : "Please enter a break purpose!",
//                             context,
//                           );
//                         }
//                       }
//                     }
//                   },
//                   color: locationProvider.isInRange
//                       ? breakProvider.isOnBreak
//                       ? Colors.red
//                       : Colors.green
//                       : Colors.grey,
//                   label: breakProvider.isOnBreak ? "End Break" : "Start Break",
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _startTimer() {
//     setState(() {
//       elapsedSeconds = 0;
//     });
//
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         elapsedSeconds++;
//       });
//     });
//   }
//
//   void _stopTimer() {
//     _timer?.cancel();
//     setState(() {});
//   }
//
//   String _formatDuration(int seconds) {
//     final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
//     final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
//     final secs = (seconds % 60).toString().padLeft(2, '0');
//     return "$hours:$minutes:$secs";
//   }
//
//   Widget _infoTile(String title, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextConst(title: title, fontSize: 16, fontWeight: FontWeight.w500),
//         TextConst(title: value, fontSize: 18, fontWeight: FontWeight.bold),
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     _purposeController.dispose();
//     super.dispose();
//   }
//
//   void _showApproverPopup(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Select Approver"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: approvers.map((approver) {
//               return ListTile(
//                 title: Text(approver),
//                 onTap: () {
//                   setState(() {
//                     selectedApprover = approver;
//                   });
//                   Navigator.pop(context);
//                 },
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }
// }
