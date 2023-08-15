import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/views/widgets/custom_formButton.dart';

import '../../api/api_manager.dart';
import '../../models/PatientInformation.dart';
import '../widgets/chronicDisease_item.dart';

class ChronicDiseasesTab extends StatelessWidget {
  const ChronicDiseasesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final String patientID = args['patientID'] ?? '';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
              } else if (snapshot.hasData &&
                  snapshot.data?.chronicDisease != null) {
                final data = snapshot.data?.chronicDisease;
                return Expanded(
                  child: ListView.builder(
                    itemCount: data?.length ?? 0,
                    itemBuilder: (_, index) {
                      return ChronicDiseaseItem(
                        chronicDisease: data?[index],
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: Text('No data available yet.'));
              }
            },
          ),
          CustomFormButton(text: 'Add New', onPressed: () {})
        ],
      ),
    );
  }
}
