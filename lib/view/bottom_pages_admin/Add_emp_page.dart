import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/res/const_files/app_btn.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/view_model/add_emp_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../res/const_files/text_const.dart';

class AddEmpPage extends StatefulWidget {
  const AddEmpPage({super.key});

  @override
  State<AddEmpPage> createState() => _AddEmpPageState();
}

class _AddEmpPageState extends State<AddEmpPage> {
  final _formKey = GlobalKey<FormState>();





  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.all(10),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.primary, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.orange, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.orangeAccent, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Provider.of<AddEmpViewModel>(context, listen: false)
          .addEmpApi(context);
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddEmpViewModel>(context, listen: false)
          .clearImage("userPhoto");
      Provider.of<AddEmpViewModel>(context, listen: false)
          .clearAllFields();
    });
  }

  @override
  Widget build(BuildContext context) {
    final addEmpViewModel = Provider.of<AddEmpViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primary,
        title: const TextConst(
          title: "Add Employee",
          fontWeight: FontWeight.bold,
          fontSize: textFontSize20,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  addEmpViewModel.pickImage(
                      ImageSource.gallery, context, "userPhoto");
                },
                child: Container(
                  width: 120, // Adjust width as needed
                  height: 120, // Adjust height as needed
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 1.5,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white, // Adjust background color if needed
                  ),
                  child: addEmpViewModel.userPhoto != null &&
                          addEmpViewModel.userPhoto!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            base64Decode(addEmpViewModel
                                .userPhoto!), // Convert Base64 to Image
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              color: AppColor.blackTemp.withOpacity(0.5),
                              size: 30,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Upload employee\nPhoto",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                ),
              ),
              spaceHeight15,
              TextFormField(
                controller: addEmpViewModel.nameController,
                decoration: _inputDecoration("Employee Name"),
                validator: (value) =>
                    value!.isEmpty ? "Please enter employee name" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addEmpViewModel.emailController,
                decoration: _inputDecoration("Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.isEmpty ? "Please enter email" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addEmpViewModel.departmentController,
                decoration: _inputDecoration("Department"),
                validator: (value) =>
                    value!.isEmpty ? "Please enter department" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addEmpViewModel.designationController,
                decoration: _inputDecoration("Designation"),
                validator: (value) =>
                    value!.isEmpty ? "Please enter designation" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addEmpViewModel.shiftController,
                decoration: _inputDecoration("Shift"),
                validator: (value) =>
                    value!.isEmpty ? "Please enter shift" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addEmpViewModel.empIdController,
                decoration: _inputDecoration("Employee ID"),
                validator: (value) =>
                    value!.isEmpty ? "Please enter employee ID" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addEmpViewModel.phoneController,
                decoration: _inputDecoration("Phone Number"),
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (value) =>
                    value!.isEmpty ? "Please enter phone number" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addEmpViewModel.passWordController,
                decoration: _inputDecoration("Password"),
                keyboardType: TextInputType.text,
                validator: (value) =>
                    value!.isEmpty ? "Please enter Password" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addEmpViewModel.addressController,
                decoration: _inputDecoration("Address"),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? "Please enter address" : null,
              ),
              const SizedBox(height: 25),
              ButtonConst(
                onTap: _submitForm,
                label: "Add Employee",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

