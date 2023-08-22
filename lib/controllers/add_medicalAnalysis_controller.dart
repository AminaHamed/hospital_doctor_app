import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:hospital_app/models/PatientInformation.dart';
import 'package:image_picker/image_picker.dart';

class AddMedicalAnalysisController extends GetxController {
  File? _pickedImage;
  DateTime selectedData = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  // late BuildContext context;

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

  File? get pickedImage => _pickedImage;

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _pickedImage = File(pickedFile.path);
      update();
    }
  }

  addAnalysis() async {
    MedicalAnalysis myTest = MedicalAnalysis();
    myTest.patientId = '1234567891234567';
    // myTest.analysisId = 3;
    // myTest.analysisDate = '7/6/2024';
    myTest.notes = 'this is a note';
    // myTest.analysisImage = pickedImage?.path;

    await ApiManager.sendMedicalAnalysis(myTest);
  }
}
