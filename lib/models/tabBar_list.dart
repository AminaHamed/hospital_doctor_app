import 'package:flutter/material.dart';
import 'package:hospital_app/views/tabs/chronic_diseases_tab.dart';
import 'package:hospital_app/views/tabs/medical_analysis_tab.dart';
import 'package:hospital_app/views/tabs/patient_details_tab.dart';
import 'package:hospital_app/views/tabs/previous_visits_tab.dart';
import 'package:hospital_app/views/tabs/xrays_tab.dart';

import '../views/tabs/add_visit_tab.dart';

List<Widget> tabs = [
  AddVisitTab(),
  PreviousVisitsTab(),
  PatientDetailsTab(),
  MedicalAnalysisTab(),
  XRaysTab(),
  ChronicDiseasesTab()
];
