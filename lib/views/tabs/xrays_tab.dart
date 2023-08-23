import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:hospital_app/models/PatientInformation.dart';
import 'package:hospital_app/views/widgets/xRay_item.dart';

import '../widgets/custom_formButton.dart';

class XRaysTab extends StatelessWidget {
  XRaysTab({Key? key}) : super(key: key);

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
              } else if (!snapshot.hasData ||
                  snapshot.data!.xRay == null ||
                  snapshot.data?.xRay?.length == 0) {
                return const Text('No xRays available for this Patient yet.');
              } else {
                final data = snapshot.data?.xRay;
                return Expanded(
                  child: ListView.builder(
                    itemCount: data?.length ?? 0,
                    itemBuilder: (_, index) {
                      return XRayItem(
                        xRay: data?[index],
                      );
                    },
                  ),
                );
              }
            },

            //   } else if (snapshot.hasData && snapshot.data?.xRay != null) {
            //     final data = snapshot.data?.xRay;
            //     return Expanded(
            //       child: ListView.builder(
            //         itemCount: data?.length ?? 0,
            //         itemBuilder: (_, index) {
            //           return XRayItem(
            //             xRay: data?[index],
            //           );
            //         },
            //       ),
            //     );
            //   } else {
            //     return const Center(child: Text('No data available yet.'));
            //   }
            // },
          ),
          CustomFormButton(text: 'Add New', onPressed: () {})
        ],
      ),
    );
  }
}
