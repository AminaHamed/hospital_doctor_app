import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/core/constants/app_theme.dart';

import 'core/constants/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.myTheme,
      routes: routes,
      initialRoute: AppRoutes.register,
    );
  }
}
