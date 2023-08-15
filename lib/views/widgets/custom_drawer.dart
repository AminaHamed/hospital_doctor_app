import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_color.dart';
import '../../core/constants/app_routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              InkWell(
                // hoverColor: AppColor.primaryColor,
                // focusColor: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  //TODO solve on tap problems
                  print('jjjjjjjjjjjjjjjjjj');
                  Get.toNamed(AppRoutes.patientRegistration);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 35,
                      color: AppColor.grey,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Patients',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColor.grey),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
