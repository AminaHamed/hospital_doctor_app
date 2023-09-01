import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/core/constants/app_routes.dart';
import 'package:hospital_app/views/widgets/custom_formButton.dart';
import 'package:hospital_app/views/widgets/custom_textFormField.dart';

import '../../../controllers/auth/register_controller.dart';
import '../../widgets/switch_sign_page_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final RegisterController controller = Get.put(RegisterController());
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sign up',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text('Sign up to access our services.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black38)),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: SwitchSignPageWidget(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.login);
                        },
                        text1: "Already have an account ? ",
                        text2: "Sign In",
                      ),
                    ),
                    CustomTextFormField(
                      label: 'Full name',
                      controller: controller.fullNameController,
                      validator: (value) => controller.validateName(value!),
                    ),
                    CustomTextFormField(
                      label: 'User Name',
                      controller: controller.userNameController,
                      validator: (value) => controller.validateUserName(value!),
                    ),
                    CustomTextFormField(
                      label: 'Phone',
                      controller: controller.phoneController,
                      validator: (value) => controller.validatePhone(value!),
                    ),
                    CustomTextFormField(
                      label: 'e-mail',
                      controller: controller.emailController,
                      validator: (value) => controller.validateEmail(value!),
                    ),
                    CustomTextFormField(
                      label: 'password',
                      controller: controller.passwordController,
                      validator: (value) => controller.validatePassword(value!),
                    ),
                    CustomTextFormField(
                      label: 'Confirm password',
                      controller: controller.confirmPasswordController,
                      validator: (value) =>
                          controller.validateConfirmPassword(value!),
                    ),
                    CustomTextFormField(
                      label: 'specialization',
                      controller: controller.specializationController,
                      validator: (value) =>
                          controller.validateSpecialization(value!),
                    ),
                    // CustomImageButton(
                    //     text: 'Choose Image',
                    //     onTap: () async {
                    //       // await controller.pickImage();
                    //     }),
                    // GetBuilder<AddMedicalAnalysisController>(builder: (controller) {
                    //   return Container(
                    //     margin: const EdgeInsets.symmetric(vertical: 25),
                    //     child: Row(
                    //       children: [
                    //         CustomOutlineBorderText(
                    //           text: '${controller.pickedImage}' ?? '',
                    //         ),
                    //       ],
                    //     ),
                    //   );
                    // }),

                    CustomFormButton(
                        text: 'Sign up',
                        onPressed: () async {
                          if (formKey.currentState?.validate() == false) {
                            return;
                          }
                          await controller.sendData();
                        })
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
