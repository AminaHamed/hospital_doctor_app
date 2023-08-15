import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';

class CustomText extends StatelessWidget {
  CustomText({Key? key, required this.text}) : super(key: key);
  String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor));
  }
}
