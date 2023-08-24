import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:hospital_app/core/constants/app_color.dart';
import 'package:hospital_app/core/constants/app_routes.dart';

class PatientRegistrationController extends GetxController {
  final TextEditingController numberController = TextEditingController();
  String patientID = '';
  late var apiData;

  String? validateNumber(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a digit number.';
    }
    if (!(value.isNumericOnly)) {
      return 'Only Numbers should be Entered.';
    }
    return null;
  }

  makeAPICall(String ID) async {
    patientID = numberController.text;
    Get.defaultDialog(
      title: 'Wait',
      content: const Center(
          child: CircularProgressIndicator(
        color: AppColor.primaryColor,
      )),
      barrierDismissible: false,
    );
    var myResponse = await ApiManager.getPatientByID(patientID);
    Get.back(canPop: false);
    if (myResponse == 'Successful ID') {
      apiData = await ApiManager.getAllPatientInfo(patientID);
      Get.toNamed(AppRoutes.patientData, arguments: patientID);
    } else {
      Get.defaultDialog(
          content: Text(myResponse,
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

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }
}
