
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:hospital_app/utils/common_controller.dart';
import 'package:http/http.dart' as http;

import '../core/constants/app_color.dart';

class AddXRayController extends CommonController {
  Future<void> sendToServer(String id) async {
    ApiManager.showWaitDialog();
    String url = 'http://momahgoub172-001-site1.atempurl.com/api/XRay/AddXRay';
    String patientId = id;
    String notes = notesController.text;

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['accept'] = '*/*';
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['patientId'] = patientId;
    request.fields['notes'] = notes;
    if (pickedImage != null) {
      var imageStream = http.ByteStream(pickedImageFile!.openRead());
      var length = await pickedImageFile!.length();
      var multipartFile = http.MultipartFile('imageFile', imageStream, length,
          filename: pickedImageFile!.path.split("/").last);

      request.files.add(multipartFile);
    }
    var response = await request.send();
    Get.back(canPop: false);

    if (response.statusCode == 200) {
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
      pickedImageFile = null;
      update();
      notesController.clear();
    } else {
      ApiManager.showMessageDialog(
          msg: 'Failed to send data. Error: ${response.statusCode} ');
      String responseBody = await response.stream.bytesToString();
      if (kDebugMode) {
        print('Response body: $responseBody');
      }
    }
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }
}
