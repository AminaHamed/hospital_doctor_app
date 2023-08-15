import 'package:flutter/material.dart';

import '../../views/screens/add_medicalAnalysis.dart';
import '../../views/screens/patient_data.dart';
import '../../views/screens/patient_registration.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes.patientRegistration: (_) => PatientRegistrationScreen(),
  AppRoutes.patientData: (_) => PatientDataScreen(),
  AppRoutes.addAnalysis: (_) => AddMedicalAnalysisScreen()
};

class AppRoutes {
  static const String patientRegistration = '/PatientRegistrationScreen';
  static const String patientData = '/PatientDataScreen';
  static const String addAnalysis = '/AddMedicalAnalysisScreen';
}
