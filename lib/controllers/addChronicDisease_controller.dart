import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:hospital_app/models/AddChronicRes.dart';
import 'package:http/http.dart' as http;

import '../core/constants/app_color.dart';

class AddChronicDiseaseController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController treatingController = TextEditingController();
  late String patientID;

  String? validateName(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a Name.';
    }
    if (value.isNumericOnly) {
      return 'Enter a String';
    }
    return null;
  }

  String? validateTreat(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a Treating.';
    }
    if (value.isNumericOnly) {
      return 'Enter a String';
    }
    return null;
  }

  sendData(String id) async {
    patientID = id;
    Get.defaultDialog(
      title: 'Wait',
      content: const Center(
          child: CircularProgressIndicator(
        color: AppColor.primaryColor,
      )),
      barrierDismissible: false,
    );
    AddChronicRes addChronicRes = AddChronicRes(
        patientId: patientID,
        treatingMedicines: treatingController.text,
        diseaseName: nameController.text);
    http.Response? response = await ApiManager.addChronic(addChronicRes);
    Get.back(canPop: false);
    if (response?.statusCode == 200) {
      Get.defaultDialog(
          content: const Text('Data Added successfully!',
              style: TextStyle(
                  fontSize: 18,
                  color: AppColor.grey,
                  fontWeight: FontWeight.bold)),
          buttonColor: AppColor.primaryColor,
          textConfirm: 'OK',
          onConfirm: () {
            Get.back(canPop: false);
          });
      print('Data sent successfully!');
      nameController.text = '';
      treatingController.text = '';
    } else {
      Get.defaultDialog(
          content: Text(
              'Failed to send data. Error: ${response?.statusCode},${response?.body} ${response?.request} ',
              style: const TextStyle(
                  fontSize: 18,
                  color: AppColor.grey,
                  fontWeight: FontWeight.bold)),
          buttonColor: AppColor.primaryColor,
          textConfirm: 'OK',
          onConfirm: () {
            Get.back(canPop: false);
          });
      print('Failed to send data. Error: ${response?.statusCode}');
      print('Response Body: ${response?.body}');
      print('  ${response?.request}');
    }
    //''
  }

  @override
  void dispose() {
    nameController.dispose();
    treatingController.dispose();
    super.dispose();
  }
}
