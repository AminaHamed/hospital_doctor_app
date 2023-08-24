import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/views/widgets/custom_appBar.dart';

import '../../controllers/addChronicDisease_controller.dart';
import '../../core/constants/app_routes.dart';
import '../widgets/custom_formButton.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textFormField.dart';

class AddChronicDiseaseScreen extends StatelessWidget {
  AddChronicDiseaseScreen({Key? key}) : super(key: key);

  AddChronicDiseaseController controller =
      Get.put(AddChronicDiseaseController());
  final patientID = Get.arguments.toString();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: 'Add new ChronicDisease'),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: 'Disease Name'),
                CustomTextFormField(
                  label: 'description',
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  controller: controller.nameController,
                  validator: (value) => controller.validateName(value!),
                ),
                CustomText(text: 'Treating Medicines'),
                CustomTextFormField(
                  label: 'description',
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  controller: controller.treatingController,
                  validator: (value) => controller.validateTreat(value!),
                ),
                CustomFormButton(
                    text: 'Submit',
                    onPressed: () async {
                      if (formKey.currentState?.validate() == false) {
                        return;
                      } else {
                        await controller.sendData(patientID);
                        Get.toNamed(AppRoutes.patientData);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
