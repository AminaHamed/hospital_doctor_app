import 'package:flutter/material.dart';
import 'package:hospital_app/core/constants/app_color.dart';

class AppTheme {
  static final ThemeData myTheme = ThemeData(
      fontFamily: 'PlayfairDisplay',
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor),
        titleMedium: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge:
            TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 1.5),
        bodyMedium:
            TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 1.5),
        bodySmall:
            TextStyle(fontSize: 15, fontWeight: FontWeight.w600, height: 1.5),
      ),
      scaffoldBackgroundColor: Colors.white);
}
