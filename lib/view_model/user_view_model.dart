import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(String userId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', userId);
    notifyListeners();
    return true;
  }

  Future<String?> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    return token;
  }

  Future<bool> remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }














  Future<bool> saveRole(String roleId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('role', roleId);
    notifyListeners();
    return true;
  }

  Future<String?> getRole() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('role');
    return token;
  }

  Future<bool> removeRole() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('role');
    return true;
  }
















}
