import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/PatientInformation.dart';
import 'custom_image_btn.dart';
import 'custom_outlineBorder_text.dart';
import 'custom_text.dart';

class MedicalAnalysisItem extends StatelessWidget {
  MedicalAnalysisItem({Key? key, this.medicalAnalysis}) : super(key: key);

  MedicalAnalysis? medicalAnalysis;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white70,
      child: Container(
        // height: 200,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                CustomText(text: 'Test Date'),
                const SizedBox(
                  width: 8,
                ),
                CustomOutlineBorderText(
                    text: medicalAnalysis?.analysisDate ?? '')
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                CustomText(text: 'Notes'),
                const SizedBox(
                  width: 8,
                ),
                CustomOutlineBorderText(text: medicalAnalysis?.notes ?? '')
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            CustomImageButton(
              text: 'View image',
              onTap: () {
                Get.defaultDialog(
                    title: 'image',
                    content: medicalAnalysis!.analysisImage!.isNotEmpty
                        ? Image.memory(
                            base64Decode(medicalAnalysis?.analysisImage ?? ''),
                            width: 200,
                            height: 200,
                          )
                        : const Text('No Image to display'));
                // Image.asset('assets/images/tesr.PNG'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
