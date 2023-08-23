import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:hospital_app/models/AddVisitRes.dart';
import 'package:http/http.dart' as http;

import '../core/constants/app_color.dart';
import '../utils/date_utils.dart';

class AddVisitController extends GetxController {
  DateTime selectedData = DateTime.now();
  TextEditingController diagnosisController = TextEditingController();
  TextEditingController pharmaceuticalController = TextEditingController();

  void showMyDatePicker(BuildContext context) async {
    var selectedPickerDate = await showDatePicker(
        context: context,
        initialDate: selectedData,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now()
        // .add(const Duration(days: 365)),
        );
    if (selectedPickerDate == null) {
      return;
    }
    selectedData = selectedPickerDate;
    update();
  }

  String? validateDiagnosis(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a diagnosis.';
    }
    if (value.isNumericOnly) {
      return 'Enter a diagnosis String';
    }
    return null;
  }

  String? validatePharmaceutical(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a Pharmaceutical.';
    }
    if (value.isNumericOnly) {
      return 'Enter a Pharmaceutical String';
    }
    return null;
  }

  sendData(String id) async {
    Get.defaultDialog(
      title: 'Wait',
      content: const Center(
          child: CircularProgressIndicator(
        color: AppColor.primaryColor,
      )),
      barrierDismissible: false,
    );
    String sendDate = MyDateUtils.formatDateToSend(selectedData);
    AddVisitRes addVisit = AddVisitRes(
        visitDate: sendDate,
        diagnosis: diagnosisController.text,
        pharmaceutical: pharmaceuticalController.text);

    http.Response? response = await ApiManager.addVisit(id, addVisit);
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
      diagnosisController.text = '';
      pharmaceuticalController.text = '';
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
    diagnosisController.dispose();
    pharmaceuticalController.dispose();
    super.dispose();
  }
}
