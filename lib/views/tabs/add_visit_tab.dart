import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/views/widgets/custom_formButton.dart';
import 'package:hospital_app/views/widgets/custom_textFormField.dart';

import '../../controllers/add_visit_controller.dart';
import '../../utils/date_widget.dart';
import '../widgets/custom_text.dart';

class AddVisitTab extends StatelessWidget {
  AddVisitTab({Key? key}) : super(key: key);

  AddVisitController controller = Get.put(AddVisitController());
  var formKey = GlobalKey<FormState>();
  final patientID = Get.arguments.toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomText(text: 'Date'),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    GetBuilder<AddVisitController>(builder: (controller) {
                      return DateWidget(
                          selectedDate: controller.selectedData,
                          onTap: () {
                            controller.showMyDatePicker(context);
                          });
                    }),
                  ],
                ),
              ),
              CustomText(text: 'Diagnosis'),
              CustomTextFormField(
                label: 'description',
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                controller: controller.diagnosisController,
                validator: (value) => controller.validateDiagnosis(value!),
              ),
              CustomText(text: 'Pharmaceutical'),
              CustomTextFormField(
                label: 'description',
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                controller: controller.pharmaceuticalController,
                validator: (value) => controller.validatePharmaceutical(value!),
              ),
              CustomFormButton(
                  text: 'Submit',
                  onPressed: () {
                    if (formKey.currentState?.validate() == false) {
                      return;
                    } else {
                      controller.sendData(patientID);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
