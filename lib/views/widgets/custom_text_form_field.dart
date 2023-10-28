import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';
import '../../core/constants/app_outLineInputBorder.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key,
      required this.label,
      this.validator,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.onTap,
      this.icon,
      this.maxLines = 1,
      this.initialValue})
      : super(key: key);
  String label;
  String? Function(String?)? validator;
  TextEditingController? controller;
  TextInputType? keyboardType;
  Icon? icon;
  int maxLines;
  String? initialValue;
  void Function(String)? onChanged;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: maxLines,
        onChanged: onChanged,
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        onTap: onTap,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(label,
                    style: const TextStyle(
                      color: AppColor.grey,
                      // fontSize: 10
                    ))),
            suffixIcon: icon,
            enabledBorder: appOutLineInputBorder(color: AppColor.grey),
            focusedBorder:
                appOutLineInputBorder(color: AppColor.green, width: 2),
            errorBorder: appOutLineInputBorder(color: Colors.red)),
      ),
    );
  }
}
