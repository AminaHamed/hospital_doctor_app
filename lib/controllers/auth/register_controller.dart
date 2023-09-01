import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:hospital_app/core/constants/app_routes.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/app_color.dart';

class RegisterController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();

  String? validateName(String value) {
    if (value.trim().isEmpty || value.trim().isNumericOnly) {
      return 'Please enter a valid fullName.';
    }
    return null;
  }

  String? validateUserName(String value) {
    if (value.trim().isEmpty ||
        value.trim().isNumericOnly ||
        value.contains(' ')) {
      return 'Please enter a valid UserName.';
    }
    return null;
  }

  String? validatePhone(String value) {
    if (value.trim().isEmpty ||
        value.trim().isAlphabetOnly ||
        value.contains(' ')) {
      return 'Please enter a valid Phone Number.';
    }
    return null;
  }

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

  String? validateConfirmPassword(String value) {
    if (value.trim().isEmpty) {
      return "confirm password is required";
    }
    if (value != passwordController.text) {
      return "password doesn't match!";
    }
    return null;
  }

  String? validateSpecialization(String value) {
    if (value.trim().isEmpty || value.trim().isNumericOnly) {
      return 'Please enter a valid Specialization.';
    }
    return null;
  }

  // File? _pickedImage;
  // File? get pickedImage => _pickedImage;
  //
  // Future<void> pickImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? pickedFile =
  //   await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     _pickedImage = File(pickedFile.path);
  //     update();
  //   }
  // }

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
      fullNameController.text = '';
      userNameController.text = '';
      phoneController.text = '';
      emailController.text = '';
      passwordController.text = '';
      confirmPasswordController.text = '';
      specializationController.text = '';
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
