import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/core/constants/app_routes.dart';
import 'package:hospital_app/models/patient_information.dart';
import 'package:hospital_app/views/widgets/custom_form_button.dart';
import 'package:http/http.dart' as http;

import '../widgets/medical_analysis_item.dart';

class MedicalAnalysisTab extends StatefulWidget {
  MedicalAnalysisTab({Key? key}) : super(key: key);

  @override
  State<MedicalAnalysisTab> createState() => _MedicalAnalysisTabState();
}

class _MedicalAnalysisTabState extends State<MedicalAnalysisTab> {

  final patientID = Get.arguments.toString();
  late StreamController<List<MedicalAnalysis>> _medicalStreamController;

  @override
  void initState() {
    super.initState();
    _medicalStreamController = StreamController<List<MedicalAnalysis>>();
    fetchXRayData(patientID);
  }

  Future<void> fetchXRayData(String id) async {
    while (true) {
      Future.delayed(const Duration(milliseconds: 500));
      final response = await http.get(Uri.parse(
          'http://momahgoub172-001-site1.atempurl.com/api/Patient/GetPatientInfo?nid=$id'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final medicalList = (jsonData['medicalAnalysis'] as List)
            .map((medicalData) => MedicalAnalysis(
                  analysisId: medicalData['analysisId'],
                  patientId: medicalData['patientId'],
                  analysisImage: medicalData['analysisImage'],
                  notes: medicalData['notes'],
                  analysisDate: medicalData['analysisDate'],
                ))
            .toList();

        print('Fetched ${medicalList.length}  records');
        _medicalStreamController.add(medicalList);

        // Debug: Check if the stream controller has listeners
        print('Stream has listeners: ${_medicalStreamController.hasListener}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: Column(
        children: [
          StreamBuilder<List<MedicalAnalysis>>(
            stream: _medicalStreamController.stream,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Error loading: ${snapshot.error.toString()}'));
              } else if (snapshot.hasData) {
                final data = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    itemCount: data?.length ?? 0,
                    itemBuilder: (_, index) {
                      return MedicalAnalysisItem(medicalAnalysis: data?[index]);
                    },
                  ),
                );
              } else {
                return const Text(
                    'No medicalAnalysis available for this Patient yet.');
              }
            },
          ),
          CustomFormButton(
              text: 'Add New',
              onPressed: () {
                Get.toNamed(AppRoutes.addAnalysis, arguments: patientID);
              })
        ],
      ),
    );
  }

  @override
  void dispose() {
    _medicalStreamController.close();
    super.dispose();
  }
}
