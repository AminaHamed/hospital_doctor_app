import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/app_color.dart';
import '../../core/constants/app_routes.dart';
import '../../utils/common_controller.dart';

class LoginController extends CommonController {
  sendData() async {
    String email = emailController.text;
    String password = passwordController.text;
    http.Response response =
        await ApiManager.login(email: email, password: password);
    Get.back(canPop: false);
    if (response.statusCode == 200) {
      emailController.clear();
      passwordController.clear();
      Get.defaultDialog(
          content: const Text('Login successful!',
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
