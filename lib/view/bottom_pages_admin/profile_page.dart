import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/generated/assets.dart';
import 'package:founder_code_hr_app/main.dart';
import 'package:founder_code_hr_app/res/const_files/app_btn.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/res/const_files/text_const.dart';
import 'package:founder_code_hr_app/utils/routes/routes_name.dart';
import 'package:founder_code_hr_app/view/auth_view/login_screen.dart';
import 'package:founder_code_hr_app/view/bottom_pages_users/profile_screen.dart';
import 'package:founder_code_hr_app/view_model/profile_view_model.dart';
import 'package:founder_code_hr_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class ProfileAdminScreen extends StatefulWidget {
  const ProfileAdminScreen({super.key});

  @override
  State<ProfileAdminScreen> createState() => _ProfileAdminScreenState();
}

class _ProfileAdminScreenState extends State<ProfileAdminScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileViewModel>(context, listen: false).profileApi(context);
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        automaticallyImplyLeading: false,
        title: const TextConst(
          title: "Admin Profile",
          fontWeight: FontWeight.bold,
          fontSize: textFontSize20,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        opacity: _opacity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: profileViewModel.modelData == null
                ? const Center(child: CircularProgressIndicator(color: AppColor.primary,))
                : profileViewModel.modelData!.data == null
                ? const Center(child: Text("No Data Found"))
                : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.5),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: profileViewModel.modelData!.data!.profileImage != null
                        ? NetworkImage(profileViewModel.modelData!.data!.profileImage.toString())
                        : const AssetImage(Assets.assetsNoInternet) as ImageProvider,
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          profileViewModel.modelData!.data!.name ?? "N/A",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.email, color: Colors.blueAccent),
                            const SizedBox(width: 8),
                            Text(
                              profileViewModel.modelData!.data!.email ?? "N/A",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.work, color: Colors.deepPurple),
                            const SizedBox(width: 8),
                            Text(
                              profileViewModel.modelData!.data!.designation ?? "N/A",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // ButtonConst(
                //   label: "LOG OUT",
                //   width: screenWidth * 0.4,
                //   onTap: () {
                //     showDialog(
                //       barrierDismissible: false,
                //       context: context,
                //       builder: (BuildContext context) {
                //         return CommonDeletePopup(
                //           title: 'Do you want to logout from the account?',
                //           yes: () {
                //             UserViewModel userViewModel = UserViewModel();
                //             userViewModel.remove();
                //            Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
                //           },
                //         );
                //       },
                //     );
                //   },
                // ),
                ButtonConst(
                  label: "LOG OUT",
                  width: screenWidth * 0.4,
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
                              Future.delayed(Duration(milliseconds: 0), () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}
