import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';

class CustomOutlineBorderText extends StatelessWidget {
  CustomOutlineBorderText({Key? key, required this.text}) : super(key: key);
  String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.grey)),
      ),
    );
  }
}
