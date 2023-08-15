import 'package:flutter/material.dart';
import 'package:hospital_app/models/XRayResponse.dart';
import 'package:hospital_app/views/tabs/chronic_diseases_tab.dart';
import 'package:hospital_app/views/tabs/medical_analysis_tab.dart';
import 'package:hospital_app/views/tabs/patient_details_tab.dart';
import 'package:hospital_app/views/tabs/previous_visits_tab.dart';
import 'package:hospital_app/views/tabs/xrays_tab.dart';

import '../views/tabs/add_visit_tab.dart';
import '../views/widgets/tabBarItem.dart';
import 'ChronicDiseaseResponse.dart';

List<TabBarItem> tabBarList = [
  TabBarItem(
    text: 'Add visit',
    isSelected: true,
  ),
  TabBarItem(text: 'Previous visits'),
  TabBarItem(text: 'Patient Details'),
  TabBarItem(text: 'Medical Analysis'),
  TabBarItem(text: 'XRays'),
  TabBarItem(text: 'Chronic Diseases'),
];

List<Widget> tabs = [
  AddVisitTab(),
  PreviousVisitsTab(),
  PatientDetailsTab(),
  MedicalAnalysisTab(),
  XRaysTab(),
  ChronicDiseasesTab()
];

List<ChronicDiseaseResponse> chronicsList = [
  ChronicDiseaseResponse(
      diagnosisDate: '4/5/2000', diseaseName: 'abx', treatingMedicines: 'ass'),
  ChronicDiseaseResponse(
      diagnosisDate: '9/8/2023', diseaseName: 'qwe', treatingMedicines: 'efs'),
  ChronicDiseaseResponse(
      diagnosisDate: '5/6/2014', diseaseName: 'bagt', treatingMedicines: 'kji'),
  ChronicDiseaseResponse(
      diagnosisDate: '3/7/2017', diseaseName: 'plm', treatingMedicines: 'poi'),
];

List<XRayResponse> xRayItemsList = [
  XRayResponse(
      xRayDate: '4/5/2000',
      notes: 'notes1',
      xRayImage: 'assets/images/tesr.PNG'),
  XRayResponse(
      xRayDate: '9/8/2023',
      notes: 'notes2',
      xRayImage: 'assets/images/tesr.PNG'),
  XRayResponse(
      xRayDate: '4/5/2000',
      notes: 'notes3',
      xRayImage: 'assets/images/tesr.PNG'),
  XRayResponse(
      xRayDate: '5/6/2014',
      notes: 'notes4',
      xRayImage: 'assets/images/tesr.PNG'),
  XRayResponse(
      xRayDate: '5/6/2014',
      notes: 'notes35',
      xRayImage: 'assets/images/tesr.PNG'),
];
