import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:hospital_app/models/add_visitRes.dart';
import 'package:http/http.dart' as http;

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
    ApiManager.showWaitDialog();
    String sendDate = MyDateUtils.formatDateToSend(selectedData);
    AddVisitRes addVisit = AddVisitRes(
        visitDate: sendDate,
        diagnosis: diagnosisController.text,
        pharmaceutical: pharmaceuticalController.text);

    http.Response? response = await ApiManager.addVisit(id, addVisit);
    Get.back(canPop: false);
    if (response?.statusCode == 200) {
      ApiManager.showMessageDialog(msg: 'Data Added successfully!');
      diagnosisController.clear();
      pharmaceuticalController.clear();
    } else {
      ApiManager.showMessageDialog(
          msg:
              'Failed to send data. Error: ${response?.statusCode},${response?.body} ${response?.request} ');
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
