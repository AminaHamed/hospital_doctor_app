import 'package:flutter/material.dart';
import 'package:hospital_app/core/constants/app_color.dart';

class TabBarItem extends StatelessWidget {
  String text;
  bool isSelected;

  TabBarItem({required this.text, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(width: 3, color: AppColor.primaryColor)),
      child: Text(
        text,
        style:
            TextStyle(color: isSelected ? Colors.white : AppColor.primaryColor),
      ),
    );
  }
}
