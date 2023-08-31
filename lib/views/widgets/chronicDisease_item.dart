import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hospital_app/api/api_manager.dart';
import 'package:hospital_app/models/PatientInformation.dart';

import 'custom_outlineBorder_text.dart';
import 'custom_text.dart';

class ChronicDiseaseItem extends StatefulWidget {
  ChronicDiseaseItem({Key? key, this.chronicDisease}) : super(key: key);

  // ChronicDiseaseResponse diseaseResponse;
  ChronicDisease? chronicDisease;

  @override
  State<ChronicDiseaseItem> createState() => _ChronicDiseaseItemState();
}

class _ChronicDiseaseItemState extends State<ChronicDiseaseItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .2,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (buildContext) async {
                await ApiManager.deleteChronic(
                    '${widget.chronicDisease?.diseaseId}' ?? '');
                setState(() {});
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            )
          ],
        ),
        child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                        text: widget.chronicDisease?.diseaseName ?? '')
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
                        text: widget.chronicDisease?.diagnosisDate ?? '')
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
                        text: widget.chronicDisease?.treatingMedicines ?? '')
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
