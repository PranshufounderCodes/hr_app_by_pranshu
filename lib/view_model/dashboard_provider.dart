import 'package:flutter/foundation.dart';

class DashboardProvider extends ChangeNotifier {

  // User
  int _selectedUserIndex = 0;

  int get selectedUserIndex => _selectedUserIndex;

  void setUserIndex(int index) {
    _selectedUserIndex = index;
    notifyListeners();
  }
// Admin
  int _selectedAdminIndex = 0;

  int get selectedAdminIndex => _selectedAdminIndex;

  void setAdminIndex(int index) {
    _selectedAdminIndex = index;
    notifyListeners();
  }
}
