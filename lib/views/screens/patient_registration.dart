import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/patienRegistration_controller.dart';
import '../widgets/custom_appBar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_formButton.dart';
import '../widgets/custom_textFormField.dart';

class PatientRegistrationScreen extends StatelessWidget {
  PatientRegistrationScreen({Key? key}) : super(key: key);
  final PatientRegistrationController controller =
      Get.put(PatientRegistrationController());
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: 'patient Registration'),
      drawer: const CustomDrawer(),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Patient ID Number :',
                  style: Theme.of(context).textTheme.titleLarge),
              CustomTextFormField(
                label: "Enter National ID",
                keyboardType: TextInputType.number,
                controller: controller.numberController,
                validator: (value) => controller.validateNumber(value!),
              ),
              CustomFormButton(
                  text: 'Submit',
                  onPressed: () async {
                    if (formKey.currentState?.validate() == false) {
                      controller.numberController.text = '';
                      return;
                    } else {
                      await controller
                          .makeAPICall(controller.numberController.text);
                      controller.numberController.text = '';
                      // print('true');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
