import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVisitController extends GetxController {
  DateTime selectedData = DateTime.now();
  TextEditingController diagnosisController = TextEditingController();
  TextEditingController pharmaceuticalController = TextEditingController();
  final RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');

  // String myNewDate=MyDateUtils.formatDateToString(selectedData);

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
    print(selectedData);
    update();
  }
}
