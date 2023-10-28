import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:hospital_app/core/constants/app_routes.dart';
import 'package:http/http.dart' as http;

import '../core/constants/app_color.dart';
import '../models/patientRes.dart';

class AddNewPatientController extends GetxController {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  String? validateID(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a digit number.';
    }
    if (!(value.isNumericOnly)) {
      return 'Only Numbers should be Entered.';
    }
    return null;
  }

  String? validatePhone(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a phone number.';
    }
    if (!(value.isNumericOnly)) {
      return 'Only Numbers should be Entered.';
    }
    return null;
  }

  String? validateAge(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a valid Age.';
    }
    if (!(value.isNumericOnly)) {
      return 'Only Numbers should be Entered.';
    }
    return null;
  }

  String? validateGender(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a valid Gender.';
    }
    if (!(value.isAlphabetOnly)) {
      return 'Only Alphabet should be Entered.';
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a valid Name.';
    }
    if (!(value.isAlphabetOnly)) {
      return 'Only Alphabet should be Entered.';
    }
    return null;
  }

  Future<void> sendData() async {
    PatientRes p = PatientRes();
    p.nid = idController.text;
    p.fullName = nameController.text;
    p.phoneNumber = phoneController.text;
    p.gender = genderController.text;
    p.age = int.parse(ageController.text);

    Map<String, dynamic> map = p.toJson();
    String jsonData = json.encode(map);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    ApiManager.showWaitDialog();
    String apiUrl =
        'http://momahgoub172-001-site1.atempurl.com/api/Doctors/AddPatient';
    http.Response response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: jsonData);
    Get.back(canPop: false);
    if (response.statusCode == 200) {
      Get.defaultDialog(
          content: const Text('Data Added successfully!',
              style: TextStyle(
                  fontSize: 18,
                  color: AppColor.grey,
                  fontWeight: FontWeight.bold)),
          buttonColor: AppColor.primaryColor,
          textConfirm: 'OK',
          onConfirm: () {
            Get.toNamed(AppRoutes.patientRegistration);
            // Get.back(canPop: false);
          });
    } else {
      ApiManager.showMessageDialog(
          msg:
              'Failed to send data. Error: ${response.statusCode},${response.body} ');
    }
    nameController.clear();
    idController.clear();
    phoneController.clear();
    ageController.clear();
    genderController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    phoneController.dispose();
    ageController.dispose();
    genderController.dispose();
    super.dispose();
  }
}
