import 'package:flutter/material.dart';
import 'package:hospital_app/models/PatientInformation.dart';

import 'custom_outlineBorder_text.dart';
import 'custom_text.dart';

class ChronicDiseaseItem extends StatelessWidget {
  ChronicDiseaseItem({Key? key, this.chronicDisease}) : super(key: key);

  // ChronicDiseaseResponse diseaseResponse;
  ChronicDisease? chronicDisease;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
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
                  CustomText(text: 'DiseaseName'),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomOutlineBorderText(
                      text: chronicDisease?.diseaseName ?? '')
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  CustomText(text: 'DiagnosisDate'),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomOutlineBorderText(
                      text: chronicDisease?.diagnosisDate ?? '')
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  CustomText(text: 'TreatingMedicines'),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomOutlineBorderText(
                      text: chronicDisease?.treatingMedicines ?? '')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
