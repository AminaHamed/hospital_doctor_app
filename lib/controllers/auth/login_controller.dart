import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/app_color.dart';
import '../../core/constants/app_routes.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? validateEmail(String value) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(value) || value.trim().isEmpty) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    // Check if the password contains at least one digit.
    if (!value.contains(RegExp(r'\d'))) {
      return 'Password must contain at least one digit';
    }

    // Check if the password contains at least one uppercase character.
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check if the password contains at least one special character.
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  sendData() async {
    String email = emailController.text;
    String password = passwordController.text;
    http.Response response =
        await ApiManager.login(email: email, password: password);
    Get.back(canPop: false);
    if (response.statusCode == 200) {
      emailController.text = '';
      passwordController.text = '';
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
      Get.defaultDialog(
          content: Text('Error: ${response.statusCode} ${response.body}',
              style: const TextStyle(
                  fontSize: 18,
                  color: AppColor.grey,
                  fontWeight: FontWeight.bold)),
          buttonColor: AppColor.primaryColor,
          textConfirm: 'OK',
          onConfirm: () {
            Get.back(canPop: false);
          });
    }
  }
}
