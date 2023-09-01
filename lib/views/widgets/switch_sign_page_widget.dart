import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';

class SwitchSignPageWidget extends StatelessWidget {
  SwitchSignPageWidget(
      {Key? key, required this.onTap, required this.text1, required this.text2})
      : super(key: key);
  void Function()? onTap;
  String text1;
  String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        InkWell(
          onTap: onTap,
          child: Text(text2,
              style: const TextStyle(
                  fontSize: 18,
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
