import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/views/widgets/custom_text.dart';

import '../../api/api_manager.dart';
import '../../models/PatientInformation.dart';
import '../widgets/custom_outlineBorder_text.dart';

class PatientDetailsTab extends StatelessWidget {
  PatientDetailsTab({Key? key}) : super(key: key);

  // final String iD = '987654321';
  // Get.arguments;

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final apiData = args['apiData'] ?? '';
    final String patientID = args['patientID'] ?? '';

    // final PatientDataTabController controller =
    //     Get.put(PatientDataTabController(iD));
    return Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        // color: Colors.deepPurple,
        child: FutureBuilder<PatientInformation>(
          future: ApiManager.getAllPatientInfo(patientID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error loading: ${snapshot.error.toString()}'));
            } else if (!snapshot.hasData ||
                snapshot.data!.patient?.nid == null) {
              return const Text('No details available for this Patient yet.');
            } else {
              final data = snapshot.data?.patient;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(text: 'Name'),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomOutlineBorderText(text: data?.fullName ?? ''),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      CustomText(text: 'Phone'),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomOutlineBorderText(text: data?.phoneNumber ?? ''),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      CustomText(text: 'Email'),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomOutlineBorderText(text: data?.email ?? ''),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      CustomText(text: 'Gender'),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomOutlineBorderText(text: data?.gender ?? ''),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      CustomText(text: 'Age'),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomOutlineBorderText(text: '${data?.age}' ?? ''),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      CustomText(text: 'Address'),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomOutlineBorderText(text: data?.address ?? ''),
                    ],
                  ),
                ],
              );
            }
          },
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Row(
          //       children: [
          //         CustomText(text: 'Name'),
          //         const SizedBox(
          //           width: 5,
          //         ),
          //         CustomOutlineBorderText(text: apiData.patient?.fullName ?? ''),
          //       ],
          //     ),
          //     const SizedBox(
          //       height: 15,
          //     ),
          //     Row(
          //       children: [
          //         CustomText(text: 'Phone'),
          //         const SizedBox(
          //           width: 5,
          //         ),
          //         CustomOutlineBorderText(
          //             text: apiData.patient?.phoneNumber ?? ''),
          //       ],
          //     ),
          //     const SizedBox(
          //       height: 15,
          //     ),
          //     Row(
          //       children: [
          //         CustomText(text: 'Email'),
          //         const SizedBox(
          //           width: 5,
          //         ),
          //         CustomOutlineBorderText(text: apiData.patient?.email ?? ''),
          //       ],
          //     ),
          //     const SizedBox(
          //       height: 15,
          //     ),
          //     Row(
          //       children: [
          //         CustomText(text: 'Gender'),
          //         const SizedBox(
          //           width: 5,
          //         ),
          //         CustomOutlineBorderText(text: apiData.patient?.gender ?? ''),
          //       ],
          //     ),
          //     const SizedBox(
          //       height: 15,
          //     ),
          //     Row(
          //       children: [
          //         CustomText(text: 'Age'),
          //         const SizedBox(
          //           width: 5,
          //         ),
          //         CustomOutlineBorderText(text: '${apiData.patient?.age}' ?? ''),
          //       ],
          //     ),
          //     const SizedBox(
          //       height: 15,
          //     ),
          //     Row(
          //       children: [
          //         CustomText(text: 'Address'),
          //         const SizedBox(
          //           width: 5,
          //         ),
          //         CustomOutlineBorderText(text: apiData.patient?.address ?? ''),
          //       ],
          //     ),
          //   ],
          // ),
        ));
  }
}
