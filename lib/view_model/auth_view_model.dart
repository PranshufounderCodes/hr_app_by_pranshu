import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/repo/auth_repo.dart';
import 'package:founder_code_hr_app/utils/routes/routes_name.dart';
import 'package:founder_code_hr_app/utils/sneck_bar.dart';
import 'package:founder_code_hr_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class LoginViewModel with ChangeNotifier {
  final _authRepo = AuthRepository();
  bool isPasswordVisible = false;
  int isAdmin = 1;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Login Api
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(context) async {
    UserViewModel userViewModel = UserViewModel();
    dynamic roleIdUser = await userViewModel.getRole();
    setLoading(true);
    Map data = {
      "employee_id": emailController.text.toString(),
      "password": passwordController.text.toString(),
      "role": isAdmin.toString()
    };

    print(data);
    _authRepo.loginApi(data).then((value) {
      final userPref = Provider.of<UserViewModel>(context, listen: false);
      if (value['success'] == true) {
        final userId = value["id"].toString(); // Convert to String
        final roleId = value["role"].toString(); // Convert to String

        userPref.saveUser(userId);
        userPref.saveRole(roleId);
        if (kDebugMode) {
          print("ramu $userId");
          print("ramusingh $roleId");
        }
        setLoading(false);

        String email = emailController.text.trim();
        String password = passwordController.text.trim();

        if (email.isEmpty || password.isEmpty) {
          showCustomSnackBar("Please enter email and password", context);

          return;
        }
        if (isAdmin == 2) {
          Navigator.pushReplacementNamed(context, RoutesName.adminDashboard);
        } else {
          Navigator.pushReplacementNamed(context, RoutesName.userDashboard);
        }
      } else if (value['success'] == false) {
        showCustomSnackBar(
          value['message'],
          context,
        );
        setLoading(false);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
