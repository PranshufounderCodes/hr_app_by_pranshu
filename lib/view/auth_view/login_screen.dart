import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/generated/assets.dart';
import 'package:founder_code_hr_app/res/const_files/app_btn.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/res/const_files/text_const.dart';
import 'package:founder_code_hr_app/utils/routes/routes_name.dart';
import 'package:founder_code_hr_app/utils/sneck_bar.dart';
import 'package:founder_code_hr_app/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  void login() {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    loginViewModel.loginApi(context);
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceHeight30,
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage(Assets.assetsLogoRemoveBg),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      spaceHeight25,
                      const TextConst(
                        title: "Proceed with Your",
                        fontSize: textFontSize20,
                      ),
                      TextConst(
                        title:
                            "Login as ${loginViewModel.isAdmin == 2 ? 'Admin' : 'User'}",
                        fontSize: textFontSize23,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 20),
                      ToggleButtons(
                        borderRadius: BorderRadius.circular(10),
                        isSelected: [
                          loginViewModel.isAdmin == 1,
                          loginViewModel.isAdmin == 2
                        ],
                        onPressed: (index) {
                          setState(() {
                            loginViewModel.isAdmin = index == 0 ? 1 : 2;
                          });
                        },
                        selectedColor: Colors.white,
                        color: Colors.black,
                        fillColor: AppColor.secondary,
                        splashColor: AppColor.secondary,
                        borderWidth: 0,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextConst(
                              title: "User",
                              fontSize: textFontSize20,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextConst(
                              title: "Admin",
                              fontSize: textFontSize20,
                            ),
                          ),
                        ],
                      ),
                      spaceHeight25,
                      TextField(
                        controller: loginViewModel.emailController,
                        decoration: InputDecoration(
                          labelText: "Username",
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(circularBorderRadius10),
                            borderSide: const BorderSide(
                                color: AppColor.secondary,
                                width: 0.7), // Border color red
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(circularBorderRadius10),
                            borderSide: const BorderSide(
                                color: AppColor.secondary,
                                width: 0.7), // Focused border color red
                          ),
                          prefixIcon: const Icon(Icons.person),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12), // Height reduce
                        ),
                      ),
                      spaceHeight25,
                      TextField(
                        controller: loginViewModel.passwordController,
                        obscureText: !loginViewModel.isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hoverColor: AppColor.primary2,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(circularBorderRadius10),
                            borderSide: const BorderSide(
                                color: AppColor.secondary,
                                width: 0.7), // Border color red
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(circularBorderRadius10),
                            borderSide: const BorderSide(
                                color: AppColor.secondary,
                                width: 0.7), // Focused border color red
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(loginViewModel.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                loginViewModel.isPasswordVisible =
                                    !loginViewModel.isPasswordVisible;
                              });
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12), // Height reduce
                        ),
                      ),
                      spaceHeight30,
                      ButtonConst(
                        onTap: login,
                        label: "Login",
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
