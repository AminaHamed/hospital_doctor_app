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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: SingleChildScrollView(
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
            // CustomTextFormField(label: 'mm/dd/yyyy',
            // icon: const Icon(Icons.calendar_month,color: AppColor.grey,),
            // keyboardType: TextInputType.datetime
            // ),

            CustomText(text: 'Diagnosis'),
            CustomTextFormField(
              label: 'description',
              keyboardType: TextInputType.multiline,
              maxLines: 2,
            ),
            CustomText(text: 'Pharmaceutical'),
            CustomTextFormField(
              label: 'description',
              keyboardType: TextInputType.multiline,
              maxLines: 3,
            ),
            CustomFormButton(text: 'Submit', onPressed: () {})
          ],
        ),
      ),
    );
  }
}
