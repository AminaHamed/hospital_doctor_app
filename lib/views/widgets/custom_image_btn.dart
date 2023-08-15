import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';

class CustomImageButton extends StatelessWidget {
  CustomImageButton({Key? key, required this.text, required this.onTap})
      : super(key: key);
  void Function()? onTap;
  String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // () async {
      //   TODO image pick
      //   await controller.pickImage();
      //   print(controller.pickedImage);
      // },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
