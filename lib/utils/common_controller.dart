import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CommonController extends GetxController {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();

  File? pickedImageFile;
  DateTime selectedData = DateTime.now();
  TextEditingController notesController = TextEditingController();

  void showMyDatePicker(BuildContext context) async {
    var selectedPickerDate = await showDatePicker(
      context: context,
      initialDate: selectedData,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedPickerDate == null) {
      return;
    }
    selectedData = selectedPickerDate;
    update();
  }

  File? get pickedImage => pickedImageFile;

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImageFile = File(pickedFile.path);
      update();
    }
  }

  String? validateNotes(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a valid Notes.';
    }
    return null;
  }

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

  String? validateNumber(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a digit number.';
    }
    if (!(value.isNumericOnly)) {
      return 'Only Numbers should be Entered.';
    }
    return null;
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }
}
