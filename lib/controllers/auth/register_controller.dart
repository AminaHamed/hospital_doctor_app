import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:hospital_app/core/constants/app_routes.dart';
import 'package:hospital_app/utils/common_controller.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/app_color.dart';

class RegisterController extends CommonController {
  sendData() async {
    String name = fullNameController.text;
    String userName = userNameController.text;
    String phone = phoneController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String specialization = specializationController.text;
    http.Response response = await ApiManager.register(
        fullName: name,
        userName: userName,
        phone: phone,
        email: email,
        password: password,
        specialization: specialization);
    Get.back(canPop: false);
    if (response.statusCode == 200) {
      fullNameController.clear();
      userNameController.clear();
      phoneController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      specializationController.clear();
      Get.defaultDialog(
          content: const Text('Registration Added successfully!',
              style: TextStyle(
                  fontSize: 18,
                  color: AppColor.grey,
                  fontWeight: FontWeight.bold)),
          buttonColor: AppColor.primaryColor,
          textConfirm: 'OK',
          onConfirm: () {
            Get.offNamed(AppRoutes.addPatient);
          });
    } else {
      ApiManager.showMessageDialog(
          msg: 'Error: ${response.statusCode} ${response.body}');
    }
  }
}
