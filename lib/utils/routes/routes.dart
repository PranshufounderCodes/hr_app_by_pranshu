
import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/utils/routes/routes_name.dart';
import 'package:founder_code_hr_app/view/auth_view/login_screen.dart';
import 'package:founder_code_hr_app/view/auth_view/splash_screen.dart';
import 'package:founder_code_hr_app/view/bottom_pages_admin/Admin_emp_view_home.dart';
import 'package:founder_code_hr_app/view/bottom_pages_admin/attendence_History_page.dart';
import 'package:founder_code_hr_app/view/bottom_pages_admin/emp_details.dart';
import 'package:founder_code_hr_app/view/bottom_pages_users/bottom_nav_bar.dart';
import 'package:founder_code_hr_app/view/bottom_pages_users/break_history.dart';

class Routers {
  static WidgetBuilder generateRoute(String routeName) {
    switch (routeName) {
      case RoutesName.splashScreen:
        return (context) => const SplashScreen();
      case RoutesName.loginScreen:
        return (context) => const LoginScreen();
      case RoutesName.userDashboard:
        return (context) => const UserDashboardView();
        case RoutesName.adminDashboard:
        return (context) => const AdminDashboardView();
        case RoutesName.breakHistory:
        return (context) => const BreakHistory();
        case RoutesName.empDetails:
        return (context) => const EmpDetails();
        case RoutesName.attendenceHistoryPage:
        return (context) => const AttendenceHistoryPage();
        case RoutesName.adminEmpViewHome:
        return (context) => const AdminEmpViewHome();


      default:
        return (context) => const Scaffold(
              body: Center(
                child: Text(
                  'No Route Found!',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            );
    }
  }
}
