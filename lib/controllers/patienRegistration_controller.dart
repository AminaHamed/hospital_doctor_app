import 'package:get/get.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:hospital_app/core/constants/app_routes.dart';

import '../utils/common_controller.dart';

class PatientRegistrationController extends CommonController {
  String patientID = '';
  late var apiData;

  makeAPICall(String ID) async {
    patientID = numberController.text;
    ApiManager.showWaitDialog();
    var myResponse = await ApiManager.getPatientByID(patientID);
    Get.back(canPop: false);
    if (myResponse == 'Successful ID') {
      apiData = await ApiManager.getAllPatientInfo(patientID);
      Get.toNamed(AppRoutes.patientData, arguments: patientID);
    } else {
      ApiManager.showMessageDialog(msg: myResponse);
    }
  }

}
