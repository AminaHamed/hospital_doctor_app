import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:hospital_app/models/PatientInformation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddMedicalAnalysisController extends GetxController {
  File? _pickedImage;
  DateTime selectedData = DateTime.now();
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

  Future<String?> pickImageAndConvertToString() async {
    final ImagePicker _picker = ImagePicker();
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // List<int> imageBytes = await pickedImage.readAsBytes();
      // String base64Image = base64Encode(imageBytes);
      return pickedImage.path;
    }

    return null;
  }

  Future<void> sendAnalysisWithImage(String patientId) async {
    final pickedImageString = await pickImageAndConvertToString();

    if (pickedImageString != null) {
      Uri apiUrl = Uri.parse(
          'http://momahgoub172-001-site1.atempurl.com/api/MedicalAnalysis/AddMedicalAnalysis');

      var request = http.MultipartRequest('POST', apiUrl)
        ..fields['PatientId'] = patientId
        ..fields['Notes'] = notesController.text
        ..fields['analysisImage'] =
            pickedImageString; // Assign the base64-encoded image string here

      try {
        final response = await request.send();
        if (response.statusCode == 200) {
          print('Analysis sent successfully!');
        } else {
          print('Failed to send analysis. Error: ${response.statusCode}');
        }
      } catch (error) {
        print('Error sending analysis: $error');
      }
    } else {
      print('No image picked');
    }
  }
}
