import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/controllers/add_newPatient_controller.dart';
import 'package:hospital_app/views/widgets/custom_appBar.dart';
import 'package:hospital_app/views/widgets/custom_drawer.dart';
import 'package:hospital_app/views/widgets/custom_formButton.dart';
import 'package:hospital_app/views/widgets/custom_textFormField.dart';

import '../widgets/custom_text.dart';

class AddPatientScreen extends StatelessWidget {
  AddPatientScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  AddNewPatientController controller = Get.put(AddNewPatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: 'Add Patient'),
      drawer: const CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CustomText(text: 'National ID'),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: CustomTextFormField(
                      label: 'ID',
                      keyboardType: TextInputType.number,
                      controller: controller.idController,
                      validator: (value) => controller.validateID(value!),
                    ))
                  ],
                ),
                Row(
                  children: [
                    CustomText(text: 'FullName'),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: CustomTextFormField(
                      label: 'Name',
                      controller: controller.nameController,
                      validator: (val) => controller.validateName(val!),
                    ))
                  ],
                ),
                Row(
                  children: [
                    CustomText(text: 'Phone'),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: CustomTextFormField(
                      label: 'Phone',
                      keyboardType: TextInputType.phone,
                      controller: controller.phoneController,
                      validator: (val) => controller.validatePhone(val!),
                    ))
                  ],
                ),
                Row(
                  children: [
                    CustomText(text: 'Gender'),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: CustomTextFormField(
                      label: 'Gender',
                      controller: controller.genderController,
                      validator: (val) => controller.validateGender(val!),
                    ))
                  ],
                ),
                Row(
                  children: [
                    CustomText(text: 'Age'),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: CustomTextFormField(
                      label: 'Age',
                      keyboardType: TextInputType.number,
                      controller: controller.ageController,
                      validator: (val) => controller.validateAge(val!),
                    ))
                  ],
                ),
                CustomFormButton(
                    text: 'Submit',
                    onPressed: () async {
                      if (formKey.currentState?.validate() == false) {
                        return;
                      } else {
                        await controller.sendData();
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
