import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/main.dart';
import 'package:founder_code_hr_app/res/const_files/app_btn.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/res/const_files/text_const.dart';
import 'package:founder_code_hr_app/utils/routes/routes_name.dart';

class AdminEmpViewHome extends StatefulWidget {
  const AdminEmpViewHome({super.key});

  @override
  State<AdminEmpViewHome> createState() => _AdminEmpViewHomeState();
}

class _AdminEmpViewHomeState extends State<AdminEmpViewHome> {
  List<String> employees = [
    "Kuldeep Singh",
    "Pankaj Kumar",
    "Akhilesh",
    "Ramu ",
    "Puneet Shukla"
  ];

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    int status = arguments?['status'] ?? "No Status";
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primary,
        title: TextConst(
          title:
              status == 1 ? "Total Employee" : status == 2 ? "Present Employee" : status == 3 ? "Absent Employee" : status == 4 ? "Half Day" : status == 5 ? "Pending" : "Employee History",
          fontWeight: FontWeight.bold,
          fontSize: textFontSize20,
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              cursorColor: AppColor.primary,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColor.primary, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.empDetails);
                  },
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primary,
                    ),
                    child: Center(
                      child: Text(
                        employees[index][0], // First letter of the name
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  title: Text(employees[index]),
                  trailing: status == 5
                      ? ButtonConst(
                          onTap: () {
                            print("object");
                          },
                          label: "Absent",
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.3,
                          color: Colors.red,
                        )
                      : Container(
                          alignment: Alignment.center,
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.1,
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: status == 2
                                ? Colors.green.shade300
                                : status == 3
                                    ? Colors.red.shade300
                                    : status == 4
                                        ? Colors.orangeAccent
                                        : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextConst(
                            textAlign: TextAlign.start,
                            fontSize: textFontSize20,
                            title:
                                status == 2 ? "P" : status == 3 ? "A" : status == 4 ? "HD" : "",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.3,
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
