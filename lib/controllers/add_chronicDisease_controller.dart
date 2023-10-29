import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:hospital_app/models/add_chronicRes.dart';
import 'package:hospital_app/utils/common_controller.dart';
import 'package:http/http.dart' as http;

import '../core/constants/app_color.dart';

class AddChronicDiseaseController extends CommonController {
  TextEditingController nameController = TextEditingController();
  TextEditingController treatingController = TextEditingController();
  late String patientID;

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
    ApiManager.showWaitDialog();
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
            Get.back();
            Get.back();
          });
      nameController.clear();
      treatingController.clear();
    } else {
      ApiManager.showMessageDialog(
          msg:
              'Failed to send data. Error: ${response?.statusCode},${response?.body} ${response?.request} ');
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
