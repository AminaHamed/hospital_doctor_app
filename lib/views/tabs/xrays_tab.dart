import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/core/constants/app_routes.dart';
import 'package:hospital_app/models/PatientInformation.dart';
import 'package:hospital_app/views/widgets/xRay_item.dart';
import 'package:http/http.dart' as http;

import '../widgets/custom_formButton.dart';

class XRaysTab extends StatefulWidget {
  XRaysTab({Key? key}) : super(key: key);

  @override
  State<XRaysTab> createState() => _XRaysTabState();
}

class _XRaysTabState extends State<XRaysTab> {
  final patientID = Get.arguments.toString();

  late StreamController<List<XRay>> _xRayStreamController;

  @override
  void initState() {
    super.initState();
    _xRayStreamController = StreamController<List<XRay>>();
    fetchXRayData(patientID);
  }

  Future<void> fetchXRayData(String id) async {
    while (true) {
      Future.delayed(const Duration(milliseconds: 500));
      final response = await http.get(Uri.parse(
          'http://momahgoub172-001-site1.atempurl.com/api/Patient/GetPatientInfo?nid=$id'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final xRayList = (jsonData['xRay'] as List)
            .map((xRayData) => XRay(
                  xRayId: xRayData['xRayId'],
                  patientId: xRayData['patientId'],
                  xRayImage: xRayData['xRayImage'],
                  notes: xRayData['notes'],
                  xRayDate: xRayData['xRayDate'],
                ))
            .toList();

        print('Fetched ${xRayList.length} x-ray records');
        _xRayStreamController.add(xRayList);

        // Debug: Check if the stream controller has listeners
        print('Stream has listeners: ${_xRayStreamController.hasListener}');
      }
    }
  }

  // PatientTabXraysController controller=Get.put(PatientTabXraysController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          StreamBuilder<List<XRay>>(
            stream: _xRayStreamController.stream,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text('Error loading: ${snapshot.error.toString()}'));
              }
              if (snapshot.hasData) {
                final data = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    itemCount: data?.length ?? 0,
                    itemBuilder: (_, index) {
                      print(data?.length ?? 0);
                      return XRayItem(
                        xRay: data?[index],
                      );
                    },
                  ),
                );
              } else {
                return const Text('No xRays available for this Patient yet.');
              }
            },
          ),
          CustomFormButton(
              text: 'Add New',
              onPressed: () {
                Get.toNamed(AppRoutes.addXRay, arguments: patientID);
              })
        ],
      ),
    );
  }

  @override
  void dispose() {
    _xRayStreamController.close();
    super.dispose();
  }
}