import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/views/widgets/custom_appBar.dart';
import 'package:hospital_app/views/widgets/custom_formButton.dart';
import 'package:hospital_app/views/widgets/custom_text.dart';
import 'package:hospital_app/views/widgets/custom_textFormField.dart';

import '../../controllers/add_medicalAnalysis_controller.dart';
import '../../utils/date_widget.dart';
import '../widgets/custom_image_btn.dart';
import '../widgets/custom_outlineBorder_text.dart';

class AddMedicalAnalysisScreen extends StatelessWidget {
  AddMedicalAnalysisScreen({Key? key}) : super(key: key);

  final AddMedicalAnalysisController controller =
      Get.put(AddMedicalAnalysisController());
  final patientID = Get.arguments.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: 'Add New Medical Analysis'),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CustomText(text: 'Date'),
                  const SizedBox(
                    width: 8,
                  ),
                  GetBuilder<AddMedicalAnalysisController>(
                      builder: (controller) {
                    return DateWidget(
                        selectedDate: controller.selectedData,
                        onTap: () {
                          controller.showMyDatePicker(context);
                        });
                  })
                ],
              ),
              Row(
                children: [
                  CustomText(text: 'Notes'),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: CustomTextFormField(
                        label: 'notes',
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                    controller: controller.notesController,
                  ))
                ],
              ),
              CustomImageButton(
                  text: 'Choose Image',
                  onTap: () async {
                    await controller.pickImage();
                    print(controller.pickedImage);
                  }),
              GetBuilder<AddMedicalAnalysisController>(builder: (controller) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 25),
                  child: Row(
                    children: [
                      CustomOutlineBorderText(
                        text: '${controller.pickedImage}' ?? '',
                      ),
                    ],
                  ),
                );
              }),
              CustomFormButton(
                  text: 'Send',
                  onPressed: () async {
                    controller.sendAnalysisWithImage(patientID);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
