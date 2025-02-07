// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:founder_code_hr_app/res/const_files/color_const.dart';
// import 'package:founder_code_hr_app/res/const_files/text_const.dart';
// import 'package:founder_code_hr_app/utils/routes/routes_name.dart';
// import 'package:founder_code_hr_app/view_model/dashboard_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// import '../../res/const_files/app_const.dart';
//
// class HomeScreenAdmin extends StatefulWidget {
//   const HomeScreenAdmin({super.key});
//
//   @override
//   State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
// }
//
// class _HomeScreenAdminState extends State<HomeScreenAdmin> {
//   int totalEmployees = 100;
//   int presentEmployees = 80;
//
//   late Timer _timer;
//   String _currentTime = '';
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize current time and start timer
//     _currentTime = _formatDateTime(DateTime.now());
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         _currentTime = _formatDateTime(DateTime.now());
//       });
//     });
//   }
//
//   String _formatDateTime(DateTime dateTime) {
//     return DateFormat('dd MMM yyyy hh:mm a').format(dateTime);
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     int absentEmployees = totalEmployees - presentEmployees;
//
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: AppColor.primary,
//         title: const TextConst(
//           title: "Admin Dashboard",
//           fontWeight: FontWeight.bold,
//           fontSize: textFontSize20,
//           color: Colors.white,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             spaceHeight20,
//             GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(context, RoutesName.adminEmpViewHome);
//               },
//               child:
//                   buildInfoCard("Total Employees", totalEmployees, Colors.blue),
//             ),
//             spaceHeight20,
//             TextConst(
//               title: "Today :- $_currentTime",
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               color: AppColor.blackTemp,
//             ),
//             spaceHeight20,
//             buildInfoCard("Present Employees", presentEmployees, Colors.green),
//             spaceHeight20,
//             buildInfoCard("Absent Employees", absentEmployees, Colors.red),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           final dashBoard =
//               Provider.of<DashboardProvider>(context, listen: false);
//           dashBoard.setAdminIndex(1);
//         },
//         backgroundColor: AppColor.primary,
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }
//
//   Widget buildInfoCard(String title, int count, Color color) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       elevation: 5,
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15.0),
//           color: color.withOpacity(0.2),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextConst(
//               title: title,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//             const SizedBox(height: 10),
//             TextConst(
//               title: count.toString(),
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/res/const_files/text_const.dart';
import 'package:founder_code_hr_app/utils/routes/routes_name.dart';
import 'package:founder_code_hr_app/view_model/dashboard_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../res/const_files/app_const.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({super.key});

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  int totalEmployees = 100;
  int presentEmployees = 80;
  int halfDay = 10;
  int pending = 8;


  late Timer _timer;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _currentTime = _formatDateTime(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _formatDateTime(DateTime.now());
      });
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy hh:mm a').format(dateTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int absentEmployees = totalEmployees - presentEmployees - halfDay - pending;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primary,
        title: const TextConst(
          title: "Admin Dashboard",
          fontWeight: FontWeight.bold,
          fontSize: textFontSize20,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.adminEmpViewHome,arguments: {'status': 1},);
              },
              child:
                  buildInfoCard("Total Employees", totalEmployees, Colors.blue),
            ),
            spaceHeight20,
            TextConst(
              title: "Today :- $_currentTime",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.blackTemp,
            ),
            spaceHeight20,
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.3,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, RoutesName.adminEmpViewHome,arguments: {'status': 2},);
                    },
                    child: buildInfoCard(
                        "Present\nEmployees", presentEmployees, Colors.green),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, RoutesName.adminEmpViewHome,arguments: {'status': 3},);
                    },
                    child: buildInfoCard(
                        "Absent\nEmployees", absentEmployees, Colors.red),
                  ),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.adminEmpViewHome,arguments: {'status': 4},);
                      },
                      child: buildInfoCard("Half Day", halfDay, Colors.orange,)),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.adminEmpViewHome,arguments: {'status': 5},);
                      },
                      child: buildInfoCard("Pending", pending, Colors.pinkAccent)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final dashBoard =
              Provider.of<DashboardProvider>(context, listen: false);
          dashBoard.setAdminIndex(1);
        },
        backgroundColor: AppColor.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget buildInfoCard(String title, int count, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: color.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextConst(
                title: title,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              const SizedBox(height: 5),
              TextConst(
                title: count.toString(),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
