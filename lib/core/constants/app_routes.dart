import 'package:flutter/material.dart';
import 'package:hospital_app/views/screens/add_patient_screen.dart';

import '../../views/screens/add_chronic_disease_screen.dart';
import '../../views/screens/add_medicalAnalysis.dart';
import '../../views/screens/add_xray.dart';
import '../../views/screens/auth/login_screen.dart';
import '../../views/screens/auth/register_screen.dart';
import '../../views/screens/patient_data.dart';
import '../../views/screens/patient_registration.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes.patientRegistration: (_) => PatientRegistrationScreen(),
  AppRoutes.patientData: (_) => PatientDataScreen(),
  AppRoutes.addAnalysis: (_) => AddMedicalAnalysisScreen(),
  AppRoutes.addPatient: (_) => AddPatientScreen(),
  AppRoutes.addChronic: (_) => AddChronicDiseaseScreen(),
  AppRoutes.addXRay: (_) => AddXRayScreen(),
  AppRoutes.register: (_) => RegisterScreen(),
  AppRoutes.login: (_) => LoginScreen(),
};

class AppRoutes {
  static const String patientRegistration = '/PatientRegistrationScreen';
  static const String patientData = '/PatientDataScreen';
  static const String addAnalysis = '/AddMedicalAnalysisScreen';
  static const String addPatient = '/AddPatientScreen';
  static const String addChronic = '/AddChronicScreen';
  static const String addXRay = '/AddXRayScreen';
  static const String register = '/RegisterScreen';
  static const String login = '/LoginScreen';
}
