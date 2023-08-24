import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddXRayController extends GetxController {
  File? _pickedImage;
  DateTime selectedData = DateTime.now();
  TextEditingController notesController = TextEditingController();

  String? validateNotes(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a valid Notes.';
    }
    return null;
  }

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
  Future<void> sendToServer(String id) async {
    String url = 'http://momahgoub172-001-site1.atempurl.com/api/XRay/AddXRay';
    String patientId = id;
    String notes = notesController.text;

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['accept'] = '*/*';
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['patientId'] = patientId;
    request.fields['notes'] = notes;
    if (pickedImage != null) {
      var imageStream = http.ByteStream(_pickedImage!.openRead());
      var length = await _pickedImage!.length();
      var multipartFile = http.MultipartFile('imageFile', imageStream, length,
          filename: _pickedImage!.path.split("/").last);

      request.files.add(multipartFile);
    }
    var response = await request.send();

    if (response.statusCode == 200) {
      print('data sent successfully.');
      notesController.text = '';
    } else {
      print('Failed to send data. Status code: ${response.statusCode}');
      String responseBody = await response.stream.bytesToString();
      print('Response body: $responseBody');
    }
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }
}
