import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/main.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/res/const_files/text_const.dart';
import 'package:founder_code_hr_app/utils/routes/routes_name.dart';

class EmpHistory extends StatefulWidget {
  const EmpHistory({super.key});

  @override
  State<EmpHistory> createState() => _EmpHistoryState();
}

class _EmpHistoryState extends State<EmpHistory> {
  List<String> employees = [
    "Kuldeep Singh",
    "Pankaj Kumar",
    "Akhilesh",
    "Ramu ",
    "Puneet Shukla"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primary,
        title: const TextConst(
          title: "Employee History",
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: TextConst(
              textAlign: TextAlign.start,
              title: "Current Month 15 Jan To 21 Jan",
              fontWeight: FontWeight.bold,
              fontSize: textFontSize20,
              color: Colors.pink,
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                return ListTile(
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
                  subtitle: Row(

                    children: [
                      Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade300,
                            borderRadius: BorderRadius.circular(5),
                          ),

                          child: TextConst(
                            textAlign: TextAlign.start,
                            fontSize: textFontSize15,
                            title: "P 10",
                            color: Colors.white,
                          )),
                      spaceWidth10,
                      Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade300,
                            borderRadius: BorderRadius.circular(5),
                          ),

                          child: TextConst(
                            textAlign: TextAlign.start,
                            fontSize: textFontSize15,
                            title: "HF 10",
                            color: Colors.black,
                          )),
                      spaceWidth10,
                      Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red.shade300,
                            borderRadius: BorderRadius.circular(5),
                          ),

                          child: TextConst(
                            textAlign: TextAlign.start,
                            fontSize: textFontSize15,
                            title: "A 8",
                            color: Colors.white,
                          )),
                    ],
                  ),
                  title: Text(employees[index]),
                  trailing: PopupMenuButton<String>(
                    color: Colors.white,
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      switch (value) {
                        case 'active':
                          print('${employees[index]} is now Active');
                          break;
                        case 'inactive':
                          print('${employees[index]} is now Inactive');
                          break;
                        case 'view':
                          Navigator.pushNamed(context, RoutesName.empDetails);
                          print('Viewing details for ${employees[index]}');
                          break;
                        default:
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem<String>(
                        value: 'view',
                        child: Text('View Employee'),
                      ),
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
                  onTap: () {
                    // Handle tap event
                    print("Tapped on ${employees[index]}");
                  },
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
