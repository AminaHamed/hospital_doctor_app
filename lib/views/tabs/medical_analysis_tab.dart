import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/core/constants/app_routes.dart';
import 'package:hospital_app/models/PatientInformation.dart';
import 'package:hospital_app/views/widgets/custom_formButton.dart';

import '../../api/api_manager.dart';
import '../../controllers/patient_medicalAnalysis_controller.dart';
import '../widgets/medical_analysis_item.dart';

class MedicalAnalysisTab extends StatelessWidget {
  MedicalAnalysisTab({Key? key}) : super(key: key);
  final controller = Get.put(MedicalAnalysisController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final String patientID = args['patientID'] ?? '';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: Column(
        children: [
          StreamBuilder<PatientInformation>(
            stream: ApiManager.getPatientInfoStream(patientID),
            builder: (BuildContext context,
                AsyncSnapshot<PatientInformation> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Error loading: ${snapshot.error.toString()}'));
              } else if (!snapshot.hasData ||
                  snapshot.data!.medicalAnalysis == null ||
                  snapshot.data?.medicalAnalysis?.length == 0) {
                return const Text(
                    'No medicalAnalysis available for this Patient yet.');
              } else {
                final data = snapshot.data?.medicalAnalysis;
                return Expanded(
                  child: ListView.builder(
                    itemCount: data?.length ?? 0,
                    itemBuilder: (_, index) {
                      return MedicalAnalysisItem(medicalAnalysis: data?[index]);
                    },
                  ),
                );
              }
            },
          ),
          CustomFormButton(
              text: 'Add New',
              onPressed: () {
                Get.toNamed(AppRoutes.addAnalysis);
              })
        ],
      ),
      // Column(
      //   children: [
      //     Expanded(
      //       child: Obx((){
      //         if (controller.medicalAnalysisList.isEmpty) {
      //           return const Center(child: CircularProgressIndicator());
      //         }else{
      //           return ListView.builder(
      //               itemCount:1,
      //               // controller.medicalAnalysisList.length,
      //           itemBuilder: (context, index) {
      //             final analysis = controller.medicalAnalysisList[index];
      //             return MedicalAnalysisItem(
      //               date: analysis.analysisDate??'',
      //               notes: analysis.notes??'',
      //               url: analysis.analysisImage??'',
      //             );
      //           }
      //
      //           );
      //         }
      //       }),
      //     ),
      //     CustomFormButton(text: 'Add New ', onPressed: (){
      //     Get.toNamed(AppRoutes.addAnalysis);
      //
      //     })
      //   ],
      // ),
      // )
    );
  }
}
