import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:founder_code_hr_app/utils/routes/routes_name.dart';
import 'package:founder_code_hr_app/view_model/auth_view_model.dart';
import 'package:founder_code_hr_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class SplashServices {
  Future<String?> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    UserViewModel userViewModel = UserViewModel();
    dynamic roleIdUser = await userViewModel.getRole();
    print("raju$roleIdUser");
    getUserData().then((value) async {
      if (kDebugMode) {
        print(value.toString());
        print('valueId');
      }
      if (value.toString() == 'null' || value.toString() == '') {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
      } else {
        await Future.delayed(const Duration(seconds: 3));
        if (roleIdUser == "2") {
          Navigator.pushReplacementNamed(context, RoutesName.adminDashboard);
        } else {
          Navigator.pushReplacementNamed(context, RoutesName.userDashboard);
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
