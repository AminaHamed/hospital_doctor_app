import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/models/AddChronicRes.dart';
import 'package:hospital_app/models/AddVisitRes.dart';
import 'package:hospital_app/models/VisitsRes.dart';
import 'package:http/http.dart' as http;

import '../core/constants/app_color.dart';
import '../models/PatientInformation.dart';

class ApiManager {
  static const String baseUrl = "momahgoub172-001-site1.atempurl.com";

  static deleteFunction(http.Response response) {
    if (response.statusCode == 200) {
      Get.defaultDialog(
          content: const Text('Data Deleted successfully!',
              style: TextStyle(
                  fontSize: 18,
                  color: AppColor.grey,
                  fontWeight: FontWeight.bold)),
          buttonColor: AppColor.primaryColor,
          textConfirm: 'OK',
          onConfirm: () {
            Get.back(canPop: false);
          });
      print('Data Deleted successfully!');
    } else if (response.statusCode == 404) {
      Get.defaultDialog(
          content: const Text('Data not found!',
              style: TextStyle(
                  fontSize: 18,
                  color: AppColor.grey,
                  fontWeight: FontWeight.bold)),
          buttonColor: AppColor.primaryColor,
          textConfirm: 'OK',
          onConfirm: () {
            Get.back(canPop: false);
          });
      print('Data not found!');
    } else {
      Get.defaultDialog(
          content: Text('${response.statusCode} ${response.body}',
              style: const TextStyle(
                  fontSize: 18,
                  color: AppColor.grey,
                  fontWeight: FontWeight.bold)),
          buttonColor: AppColor.primaryColor,
          textConfirm: 'OK',
          onConfirm: () {
            Get.back(canPop: false);
          });
      print('${response.statusCode} ${response.body}');
    }
  }

  static showWaitDialog() {
    Get.defaultDialog(
      title: 'Wait',
      content: const Center(
          child: CircularProgressIndicator(
        color: AppColor.primaryColor,
      )),
      barrierDismissible: false,
    );
  }

  static Future<void> deleteChronic(String id) async {
    showWaitDialog();
    String apiUrl =
        'http://momahgoub172-001-site1.atempurl.com/api/ChronicDisease/DeleteChronicDisease?diseaseId=$id';
    http.Response response = await http.delete(Uri.parse(apiUrl));
    Get.back(canPop: false);
    deleteFunction(response);
  }

  static Future<void> deleteXray(String id) async {
    showWaitDialog();
    String apiUrl =
        'http://momahgoub172-001-site1.atempurl.com/api/XRay/DeleteXRay?xrayId=$id';
    http.Response response = await http.delete(Uri.parse(apiUrl));
    Get.back(canPop: false);
    deleteFunction(response);
  }

  static Future<void> deleteMedicalAnalysis(String id) async {
    showWaitDialog();
    String apiUrl =
        'http://momahgoub172-001-site1.atempurl.com/api/MedicalAnalysis/DeleteMedicalAnalysis?medicalId=$id';
    http.Response response = await http.delete(Uri.parse(apiUrl));
    Get.back(canPop: false);
    deleteFunction(response);
  }

  static Future<http.Response?> addChronic(AddChronicRes addChronicRes) async {
    String apiUrl =
        'http://momahgoub172-001-site1.atempurl.com/api/ChronicDisease/AddChronicDisease';
    try {
      Map<String, dynamic> map = addChronicRes.toJson();
      String jsonData = json.encode(map);
      Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json',
      };
      return await http.post(Uri.parse(apiUrl),
          headers: headers, body: jsonData);
    } catch (e) {
      print(e);
    }
  }

  static Future<http.Response?> addVisit(
      String id, AddVisitRes addVisitRes) async {
    String apiUrl =
        'http://momahgoub172-001-site1.atempurl.com/api/PreviousVisits/AddVisit?PatientId=$id';
    try {
      // Map<String, dynamic> map = addVisitRes.toJson();

      Map<String, dynamic> data = {
        "visitDate": addVisitRes.visitDate.toString(),
        "pharma": [
          {
            "diagnosis": addVisitRes.pharmaceutical.toString(),
            "pharmaceutical": addVisitRes.diagnosis.toString()
          }
        ]
      };

      // List<Map<String, dynamic>> data = [
      //   {
      //     "visitDate": addVisitRes.visitDate.toString(),
      //     "diagnosis": addVisitRes.pharmaceutical.toString(),
      //     "pharmaceutical": addVisitRes.diagnosis.toString()
      //   }
      // ];
      // String jsonData = json.encode(map);
      String jsonData = json.encode(data);
      Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json',
      };
      return await http.post(Uri.parse(apiUrl),
          headers: headers, body: jsonData);
    } catch (e) {
      print(e);
    }
  }

  static Future<PatientInformation> getAllPatientInfo(String id) async {
    var url = Uri.http(baseUrl, '/api/Patient/GetPatientInfo', {'nid': id});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return PatientInformation.fromJson(jsonDecode(response.body));
    } else {
      return PatientInformation();
    }
  }

  static Stream<PatientInformation> getPatientInfoStream(String id) {
    return Stream.fromFuture(getAllPatientInfo(id));
  }

  static Future<List<VisitsRes>> getPreviousVisits(String id) async {
    String apiUrl =
        'http://momahgoub172-001-site1.atempurl.com/api/PreviousVisits/GetAllVisitsByPatientId?id=$id';
    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<VisitsRes> visits =
          jsonData.map((data) => VisitsRes.fromJson(data)).toList();
      return visits;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  static Stream<List<VisitsRes>> getPreviousVisitsStream(String id) {
    return Stream.fromFuture(getPreviousVisits(id));
  }

  static getPatientByID(String ID) async {
    var url = Uri.http(baseUrl, '/api/Patient/GetPatientByNID', {'nid': ID});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return 'Successful ID';
    } else if (response.statusCode == 204) {
      return 'no user with this id';
    } else if (response.statusCode == 400) {
      return 'The nid field is required';
    } else {
      return throw Exception('Failed to load Patient try again later');
    }
  }


  static sendMedicalAnalysis(MedicalAnalysis object) async {
    Map<String, dynamic> map = object.toJson();
    String jsonData = json.encode(map);
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
    String apiUrl =
        'http://momahgoub172-001-site1.atempurl.com/api/MedicalAnalysis/AddMedicalAnalysis';
    http.Response response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: jsonData);
    if (response.statusCode == 200) {
      print('Data sent successfully!');
      print('Failed to send data. Error: ${response.body}');
    } else {
      print('Failed to send data. Error: ${response.statusCode}');
      print('Failed to send data. Error: ${response.body}');
    }
  }
}
