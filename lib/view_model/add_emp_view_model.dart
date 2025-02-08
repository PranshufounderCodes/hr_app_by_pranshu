import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/model/emp_history_model.dart';
import 'package:founder_code_hr_app/repo/admin_emp_repo.dart';
import 'package:founder_code_hr_app/utils/sneck_bar.dart';
import 'package:founder_code_hr_app/view/bottom_pages_admin/emp_details.dart';
import 'package:image_picker/image_picker.dart';

class AddEmpViewModel with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  String? userPhoto;

  Future<void> pickImage(
      ImageSource source, BuildContext context, String docType) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        File imageFile = File(image.path);
        List<int> imageBytes = await imageFile.readAsBytes();
        String encodedImage = base64Encode(imageBytes);

        if (docType == "userPhoto") {
          userPhoto = encodedImage;
          notifyListeners(); // Notify after updating
        }
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void clearImage(String docType) {
    if (docType == "userPhoto") {
      userPhoto = null;
      notifyListeners(); // Notify after clearing
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController shiftController = TextEditingController();
  final TextEditingController empIdController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    departmentController.dispose();
    designationController.dispose();
    shiftController.dispose();
    empIdController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void clearAllFields() {
    nameController.clear();
    emailController.clear();
    departmentController.clear();
    designationController.clear();
    shiftController.clear();
    empIdController.clear();
    phoneController.clear();
    addressController.clear();
    passWordController.clear();
  }

  final Employee _employee = Employee(
    name: "rami",
    empId: "Founder1234",
    email: "dhdhdhhd@gmail.com",
    department: "Trial Department",
    designation: "Trial Designation",
    shift: "Trial Shift",
    shiftTimings: "10:00 AM TO 07:00 PM",
    phone: "8318686043",
    country: "India",
  );

  Employee get employee => _employee;

  final _adminEmpRepo = AdminEmpRepo();

  // Add Admin Api
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> addEmpApi(context) async {
    setLoading(true);
    Map data = {
      "employee_id": empIdController.text.toString(),
      "name": nameController.text.toString(),
      "email": emailController.text.toString(),
      "country": "India",
      "phone": phoneController.text.toString(),
      "designation": designationController.text.toString(),
      "department": departmentController.text.toString(),
      "shift": "Day Shift",
      "address": addressController.text.toString(),
      "profileImage": userPhoto,
      "password": passWordController.text,
    };

    print(data);
    _adminEmpRepo.addEmpApi(data).then((value) {
      if (value['success'] == true) {
        setLoading(false);
        showCustomSnackBar(
          value['message'],
          context,
        );
        clearAllFields();
      } else {
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

//   Emp History Api

  bool _loadingEMPH = false;

  bool get loadingEMPH => _loadingEMPH;

  setLoadingEMPH(bool value) {
    _loadingEMPH = value;
    notifyListeners();
  }

  EmpHistoryModel? _empHistoryModelData;
  EmpHistoryModel? get empHistoryModelData => _empHistoryModelData;

  setEmpHistoryModelData(EmpHistoryModel value) {
    _empHistoryModelData = value;
    notifyListeners();
  }

  Future<void> empHistoryApi(context, String searchCon) async {
    setLoadingEMPH(true);
    Map data = {"name": searchCon};

    print(data);
    _adminEmpRepo.empHistoryApi(data).then((value) {
      if (value.success == true) {
        setLoadingEMPH(false);
        showCustomSnackBar(
          value.message,
          context,
        );
        setEmpHistoryModelData(value);
      } else {
        showCustomSnackBar(
          value.success,
          context,
        );
        setLoadingEMPH(false);
      }
    }).onError((error, stackTrace) {
      setLoadingEMPH(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
