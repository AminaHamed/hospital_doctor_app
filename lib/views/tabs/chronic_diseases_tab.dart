import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/core/constants/app_routes.dart';
import 'package:hospital_app/views/widgets/custom_formButton.dart';
import 'package:http/http.dart' as http;

import '../../models/PatientInformation.dart';
import '../widgets/chronicDisease_item.dart';

class ChronicDiseasesTab extends StatefulWidget {
  ChronicDiseasesTab({Key? key}) : super(key: key);

  @override
  State<ChronicDiseasesTab> createState() => _ChronicDiseasesTabState();
}

class _ChronicDiseasesTabState extends State<ChronicDiseasesTab> {
  final patientID = Get.arguments.toString();
  late StreamController<List<ChronicDisease>> _chronicStreamController;

  @override
  void initState() {
    super.initState();
    _chronicStreamController = StreamController<List<ChronicDisease>>();
    fetchXRayData(patientID);
  }

  Future<void> fetchXRayData(String id) async {
    while (true) {
      Future.delayed(const Duration(milliseconds: 500));
      final response = await http.get(Uri.parse(
          'http://momahgoub172-001-site1.atempurl.com/api/Patient/GetPatientInfo?nid=$id'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final chronicList = (jsonData['chronicDisease'] as List)
            .map((chronicData) => ChronicDisease(
                  diseaseId: chronicData['diseaseId'],
                  patientId: chronicData['patientId'],
                  diseaseName: chronicData['diseaseName'],
                  diagnosisDate: chronicData['diagnosisDate'],
                  treatingMedicines: chronicData['treatingMedicines'],
                ))
            .toList();

        print('Fetched ${chronicList.length}  records');
        _chronicStreamController.add(chronicList);
        print('Stream has listeners: ${_chronicStreamController.hasListener}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          StreamBuilder<List<ChronicDisease>>(
            stream: _chronicStreamController.stream,
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
                      return ChronicDiseaseItem(chronicDisease: data?[index]);
                    },
                  ),
                );
              } else {
                return const Text(
                    'No chronicDisease available for this Patient yet.');
              }
            },
          ),
          CustomFormButton(
              text: 'Add New',
              onPressed: () {
                Get.toNamed(AppRoutes.addChronic, arguments: patientID);
              })
        ],
      ),
    );
  }

  @override
  void dispose() {
    _chronicStreamController.close();
    super.dispose();
  }
}
