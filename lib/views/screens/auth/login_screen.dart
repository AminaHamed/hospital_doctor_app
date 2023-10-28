import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/controllers/auth/login_controller.dart';
import 'package:hospital_app/core/constants/app_color.dart';
import 'package:hospital_app/views/widgets/custom_appBar.dart';

import '../../../core/constants/app_routes.dart';
import '../../widgets/custom_form_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/switch_sign_page_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final LoginController controller = Get.put(LoginController());
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: ' '),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text('Sign in',
                //     style: Theme.of(context).textTheme.titleLarge),
                Text('Welcome Back..',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: AppColor.primaryColor)),
                // SizedBox(height: 10,),
                Text('Sign in to access our services.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black38)),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 30),
                  child: SwitchSignPageWidget(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.register);
                    },
                    text1: "Don't have an account ? ",
                    text2: "Sign Up",
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        label: 'e-mail',
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.emailController,
                        validator: (value) => controller.validateEmail(value!),
                      ),
                      CustomTextFormField(
                        label: 'password',
                        controller: controller.passwordController,
                        validator: (value) =>
                            controller.validatePassword(value!),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
