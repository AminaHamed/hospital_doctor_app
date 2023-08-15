import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';

class CustomFormButton extends StatelessWidget {
  CustomFormButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  void Function()? onPressed;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 10,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: AppColor.primaryColor),
          onPressed: onPressed,
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
          )),
    );
  }
}
