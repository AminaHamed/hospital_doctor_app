import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/MedicalAnalysisResponse.dart';

class MedicalAnalysisController extends GetxController {
  RxList<MedicalAnalysisResponse> medicalAnalysisList =
      RxList<MedicalAnalysisResponse>();

  @override
  void onInit() {
    super.onInit();
    fetchMedicalAnalysisData();
  }

  Future<void> fetchMedicalAnalysisData() async {
    final response = await http.get(Uri.parse(
        "http://momahgoub172-001-site1.atempurl.com/api/MedicalAnalysis/GetMedicalAnalysesByPatientNID?nid=123456789"));
    // var response= await ApiManager.getMedicalAnalysisData('123456789');
    if (response.statusCode == 200) {
      // return MedicalAnalysisResponse.fromJson(jsonDecode(response.body));
      final jsonData = json.decode(response.body);
      medicalAnalysisList.assignAll(
        (jsonData as List)
            .map((data) => MedicalAnalysisResponse(
                  analysisDate: data['analysisDate'],
                  notes: data['notes'],
                  analysisImage: data['analysisImage'],
                ))
            .toList(),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }
}
