import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/main.dart';
import 'package:founder_code_hr_app/res/const_files/app_btn.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/res/const_files/text_const.dart';
import 'package:founder_code_hr_app/utils/routes/routes_name.dart';
import 'package:founder_code_hr_app/view_model/add_emp_view_model.dart';
import 'package:provider/provider.dart';

// Employees Data Model
class Employee {
  final String name;
  final String empId;
  final String email;
  final String department;
  final String designation;
  final String shift;
  final String shiftTimings;
  final String phone;
  final String country;

  Employee({
    required this.name,
    required this.empId,
    required this.email,
    required this.department,
    required this.designation,
    required this.shift,
    required this.shiftTimings,
    required this.phone,
    required this.country,
  });
}

// Employees Provider

// Employees Details Page UI
class EmpDetails extends StatelessWidget {
  const EmpDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final employee = Provider.of<AddEmpViewModel>(context).employee;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        leadingWidth: screenWidth,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const TextConst(
                title: "Employees Details",
                fontWeight: FontWeight.bold,
                fontSize: textFontSize20,
                color: Colors.white,
              ),
            ),
            PopupMenuButton<String>(
              color: Colors.white,
              icon: const Icon(
                Icons.more_vert,
                color: AppColor.white10,
              ),
              onSelected: (value) {
                switch (value) {
                  case 'active':
                    break;
                  case 'inactive':
                    break;
                  case 'view':
                    Navigator.pushNamed(context, RoutesName.empDetails);

                    break;
                  default:
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: 'active',
                  child: Text('Make Active'),
                ),
                const PopupMenuItem<String>(
                  value: 'inactive',
                  child: Text('Make Inactive'),
                ),
                const PopupMenuItem<String>(
                  value: 'Delete',
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            color: AppColor.primary,
            width: screenWidth,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                spaceHeight10,
                Text(
                  employee.name,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                spaceHeight5,
                Text(
                  employee.email,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                spaceHeight5,
                Text(
                  employee.designation,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          // Employee Information
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoRow(title: "Full Name", value: employee.name),
                    InfoRow(title: "Department", value: employee.department),
                    InfoRow(title: "Designation", value: employee.designation),
                    InfoRow(title: "Emp ID", value: employee.empId),
                    InfoRow(title: "Shift", value: employee.shift),
                    InfoRow(
                        title: "Shift Timings", value: employee.shiftTimings),

                    spaceHeight10,

                    // Contact Info Section
                    const TextConst(
                      title: "Contact Info",
                      fontSize: textFontSize20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    const Divider(),
                    InfoRow(title: "Phone", value: employee.phone),
                    InfoRow(title: "Email", value: employee.email),
                    InfoRow(title: "Country", value: employee.country),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonConst(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RoutesName.attendenceHistoryPage);
                  },
                  width: screenWidth * 0.4,
                  label: "Attendence",
                ),
                ButtonConst(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.breakHistory);
                  },
                  width: screenWidth * 0.4,
                  label: "Break",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextConst(
              textAlign: TextAlign.start,
              title: title,
              fontWeight: FontWeight.bold,
              fontSize: textFontSize17,
              color: AppColor.blackTemp,
            ),
          ),
          Expanded(
            flex: 3,
            child: TextConst(
              textAlign: TextAlign.start,
              title: value,
              fontSize: textFontSize17,
            ),
          ),
        ],
      ),
    );
  }
}
