import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/view/bottom_pages_admin/Add_emp_page.dart';
import 'package:founder_code_hr_app/view/bottom_pages_admin/emp_history.dart';
import 'package:founder_code_hr_app/view/bottom_pages_admin/home_screen_admin.dart';
import 'package:founder_code_hr_app/view/bottom_pages_admin/profile_page.dart';
import 'package:founder_code_hr_app/view_model/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:founder_code_hr_app/utils/sneck_bar.dart';
import 'package:founder_code_hr_app/view/bottom_pages_users/break_screen.dart';
import 'package:founder_code_hr_app/view/bottom_pages_users/history_screen.dart';
import 'package:founder_code_hr_app/view/bottom_pages_users/home_screen.dart';
import 'package:founder_code_hr_app/view/bottom_pages_users/profile_screen.dart';

class UserDashboardView extends StatefulWidget {
  const UserDashboardView({super.key});

  @override
  _UserDashboardViewState createState() => _UserDashboardViewState();
}

class _UserDashboardViewState extends State<UserDashboardView> {
  DateTime? _lastPressedTime;

  final List<Widget> _pages = [
    const HomePageUser(),
    const HistoryPage(),
    const BreakPage(),
    const ProfilePage(),
  ];

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (_lastPressedTime == null || now.difference(_lastPressedTime!) > const Duration(seconds: 2)) {
      _lastPressedTime = now;
      showCustomSnackBar('Press back again to exit', context);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
          child: _pages[provider.selectedUserIndex],
        ),
        bottomNavigationBar: _buildBottomNavBar(provider.selectedUserIndex, provider.setUserIndex),
      ),
    );
  }

  Widget _buildBottomNavBar(int currentIndex, Function(int) onTap) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: BottomNavigationBar(
        backgroundColor: AppColor.white10,
        elevation: 10,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.free_breakfast), label: 'Break'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  _AdminDashboardViewState createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  DateTime? _lastPressedTime;

  final List<Widget> _pages = [
    const HomeScreenAdmin(),
    const AddEmpPage(),
    const EmpHistory(),
    const ProfileAdminScreen(),
  ];

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (_lastPressedTime == null || now.difference(_lastPressedTime!) > const Duration(seconds: 2)) {
      _lastPressedTime = now;
      showCustomSnackBar('Press back again to exit', context);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
          child: _pages[provider.selectedAdminIndex],
        ),
        bottomNavigationBar: _buildBottomNavBar(provider.selectedAdminIndex, provider.setAdminIndex),
      ),
    );
  }

  Widget _buildBottomNavBar(int currentIndex, Function(int) onTap) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: BottomNavigationBar(
        backgroundColor: AppColor.white10,
        elevation: 10,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_business_rounded), label: 'Add Emp'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Emp History'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}
