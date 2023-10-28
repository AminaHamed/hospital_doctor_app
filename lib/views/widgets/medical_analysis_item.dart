import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../api/api_manager.dart';
import '../../models/patient_information.dart';
import 'custom_image_btn.dart';
import 'custom_outlineBorder_text.dart';
import 'custom_text.dart';

class MedicalAnalysisItem extends StatefulWidget {
  MedicalAnalysisItem({Key? key, this.medicalAnalysis}) : super(key: key);

  MedicalAnalysis? medicalAnalysis;

  @override
  State<MedicalAnalysisItem> createState() => _MedicalAnalysisItemState();
}

class _MedicalAnalysisItemState extends State<MedicalAnalysisItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: .2,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (buildContext) async {
              await ApiManager.deleteMedicalAnalysis(
                  '${widget.medicalAnalysis?.analysisId}' ?? '');
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
                      text: widget.medicalAnalysis?.analysisDate ?? '')
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
                  CustomOutlineBorderText(
                      text: widget.medicalAnalysis?.notes ?? '')
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
                      content: widget.medicalAnalysis!.analysisImage!.isNotEmpty
                          ? Image.memory(
                              base64Decode(
                                  widget.medicalAnalysis?.analysisImage ?? ''),
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
      ),
    );
  }
}
