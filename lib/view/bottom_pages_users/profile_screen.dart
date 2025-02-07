import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/main.dart';
import 'package:founder_code_hr_app/res/const_files/app_btn.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/res/const_files/text_const.dart';
import 'package:founder_code_hr_app/utils/routes/routes_name.dart';
import 'package:founder_code_hr_app/view/auth_view/login_screen.dart';
import 'package:founder_code_hr_app/view_model/profile_view_model.dart';
import 'package:founder_code_hr_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileViewModel>(context, listen: false).profileApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final profile = profileViewModel.modelData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        automaticallyImplyLeading: false,
        title: const TextConst(
          title: "Profile",
          fontWeight: FontWeight.bold,
          fontSize: textFontSize20,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: profile == null
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColor.primary,
            ))
          : profile.data == null
              ? const Center(child: Text("No Data Found"))
              : Column(
                  children: [
                    Container(
                      color: AppColor.primary,
                      width: screenWidth,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage: profile.data?.profileImage != null
                                ? NetworkImage(profile.data!.profileImage!)
                                : null,
                            child: profile.data?.profileImage == null
                                ? const Icon(Icons.person,
                                    size: 40, color: Colors.white)
                                : null,
                          ),
                          spaceHeight10,
                          Text(
                            profile.data!.name ?? "N/A",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          spaceHeight5,
                          Text(
                            profile.data!.email ?? "N/A",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          spaceHeight5,
                          Text(
                            profile.data!.designation ?? "N/A",
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InfoRow(
                                  title: "Full Name",
                                  value: profile.data!.name ?? "N/A"),
                              InfoRow(
                                  title: "Department",
                                  value: profile.data!.department ?? "N/A"),
                              InfoRow(
                                  title: "Designation",
                                  value: profile.data!.designation ?? "N/A"),
                              InfoRow(
                                  title: "Emp ID",
                                  value: profile.data!.employeeId ?? "N/A"),
                              InfoRow(
                                  title: "Shift",
                                  value: profile.data!.shift ?? "N/A"),
                              const InfoRow(
                                  title: "Shift Timings",
                                  value: "10:00 AM TO 7:00 PM"),
                              spaceHeight10,
                              const TextConst(
                                title: "Contact Info",
                                fontSize: textFontSize20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                              const Divider(),
                              InfoRow(
                                  title: "Phone",
                                  value: profile.data!.phone ?? "N/A"),
                              InfoRow(
                                  title: "Email",
                                  value: profile.data!.email ?? "N/A"),
                              InfoRow(
                                  title: "Country",
                                  value: profile.data!.country ?? "N/A"),
                              // Align(
                              //   alignment: AlignmentDirectional.centerEnd,
                              //   child: ButtonConst(
                              //     label: "LOG OUT",
                              //     height: screenHeight * 0.05,
                              //     width: screenWidth * 0.3,
                              //     onTap: () {
                              //       showDialog(
                              //           barrierDismissible: false,
                              //           context: context,
                              //           builder: (BuildContext context) {
                              //             return CommonDeletePopup(
                              //                 title: 'Do you want to logout from the account',
                              //                 yes: () {
                              //                   UserViewModel userViewModel = UserViewModel();
                              //                   userViewModel.remove();
                              //                   Navigator.pushNamedAndRemoveUntil(
                              //                     context,
                              //                     RoutesName.loginScreen,
                              //                         (Route<dynamic> route) => false,
                              //                   );
                              //                 });
                              //           });
                              //     },
                              //   ),
                              // )
                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child:

                                ButtonConst(
                                  label: "LOG OUT",
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.3,
                                  onTap: () {
                                    if (mounted) {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return CommonDeletePopup(
                                            title: 'Do you want to logout from the account?',

                                            yes: () {
                                              Navigator.of(context).pop();

                                              UserViewModel userViewModel = Provider.of<UserViewModel>(context, listen: false);
                                              userViewModel.remove();
                                              userViewModel.removeRole();
                                              userViewModel.notifyListeners();
                                              Future.delayed(const Duration(milliseconds: 0), () {
                                                Navigator.of(context).pushAndRemoveUntil(
                                                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                                                      (Route<dynamic> route) => false,
                                                );
                                              });
                                            },

                                          );
                                        },
                                      );
                                    }
                                  },
                                ),


                              ),

                            ],
                          ),
                        ),
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


class CommonDeletePopup extends StatelessWidget {
  final String title;
  final VoidCallback yes;

  const CommonDeletePopup({Key? key, required this.title, required this.yes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirmation"),
      content: Text(title),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Closes the dialog
          },
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () {
            yes();
            Navigator.of(context).pop(); // Close dialog after action
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}
