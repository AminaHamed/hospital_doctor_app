import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/controllers/add_newPatient_controller.dart';
import 'package:hospital_app/views/widgets/custom_appBar.dart';
import 'package:hospital_app/views/widgets/custom_drawer.dart';
import 'package:hospital_app/views/widgets/custom_formButton.dart';
import 'package:hospital_app/views/widgets/custom_textFormField.dart';
import 'package:http/http.dart' as http;

import '../../models/PatientRes.dart';
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
                      keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.number,
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
                    onPressed: () {
                      if (formKey.currentState?.validate() == false) {
                        return;
                      } else {
                        // PatientRes p=PatientRes();
                        // p.nid=controller.idController.text;
                        // p.fullName=controller.nameController.text;
                        // p.phoneNumber=controller.phoneController.text;
                        // p.gender=controller.genderController.text;
                        // p.age= int.parse(controller.ageController.text);
                        controller.sendData();
                      }
                      // PatientRes p=PatientRes();
                      // p.fullName='amin';
                      // p.gender='male';
                      // p.nid='12345';
                      // p.phoneNumber='1234';
                      // p.age=30;
                      // testSend(p);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> testSend(PatientRes patient) async {
    Map<String, dynamic> map = patient.toJson();
    String jsonData = json.encode(map);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String apiUrl =
        'http://momahgoub172-001-site1.atempurl.com/api/Doctors/AddPatient';
    http.Response response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: jsonData);
    if (response.statusCode == 200) {
      print('Data sent successfully!');
    } else {
      print('Failed to send data. Error: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }
  }
}
