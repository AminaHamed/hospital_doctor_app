import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/models/add_chronicRes.dart';
import 'package:hospital_app/models/add_visitRes.dart';
import 'package:hospital_app/models/visitsRes.dart';
import 'package:http/http.dart' as http;

import '../core/constants/app_color.dart';
import '../models/patient_information.dart';

class ApiManager {
  static const String baseUrl = "momahgoub172-001-site1.atempurl.com";

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

  static showMessageDialog(
      {required String msg, bool canPop = false, void Function()? onConfirm}) {
    Get.defaultDialog(
        content: Text(msg,
            style: const TextStyle(
                fontSize: 18,
                color: AppColor.grey,
                fontWeight: FontWeight.bold)),
        buttonColor: AppColor.primaryColor,
        textConfirm: 'OK',
        onConfirm: () {
          Get.back(canPop: canPop);
        });
  }

  static deleteFunction(http.Response response) {
    if (response.statusCode == 200) {
      showMessageDialog(msg: "Data Deleted successfully!");
      if (kDebugMode) {
        print('Data Deleted successfully!');
      }
    } else if (response.statusCode == 404) {
      showMessageDialog(msg: 'Data not found!');
    } else {
      showMessageDialog(msg: '${response.statusCode} ${response.body}');
    }
  }


  static Future<http.Response> register(
      {required String fullName,
      required String userName,
      required String phone,
      required String email,
      required String password,
      required String specialization}) async {
    showWaitDialog();
    String apiUrl =
        'http://momahgoub172-001-site1.atempurl.com/api/Auth/DoctorRegister';
    Map<String, dynamic> data = {
      "fullName": fullName,
      "phoneNumber": phone,
      "userName": userName,
      "email": email,
      "password": password,
      "specialization": specialization,
      "description": "string",
      "imageUrl": "string"
    };
    String jsonData = json.encode(data);
    Map<String, String> headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
    return await http.post(Uri.parse(apiUrl), headers: headers, body: jsonData);
  }

  static Future<http.Response> login(
      {required String email, required String password}) async {
    showWaitDialog();
    String apiUrl = 'http://momahgoub172-001-site1.atempurl.com/api/Auth/Login';
    Map<String, dynamic> data = {"email": email, "password": password};
    String jsonData = json.encode(data);
    Map<String, String> headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
    return await http.post(Uri.parse(apiUrl), headers: headers, body: jsonData);
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
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<http.Response?> addVisit(
      String id, AddVisitRes addVisitRes) async {
    String apiUrl =
        'http://momahgoub172-001-site1.atempurl.com/api/PreviousVisits/AddVisit?PatientId=$id';
    try {
      Map<String, dynamic> data = {
        "visitDate": addVisitRes.visitDate.toString(),
        "pharma": [
          {
            "diagnosis": addVisitRes.pharmaceutical.toString(),
            "pharmaceutical": addVisitRes.diagnosis.toString()
          }
        ]
      };

      String jsonData = json.encode(data);
      Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json',
      };
      return await http.post(Uri.parse(apiUrl),
          headers: headers, body: jsonData);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
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
      if (kDebugMode) {
        print('Data sent successfully!');
      }
      if (kDebugMode) {
        print('Failed to send data. Error: ${response.body}');
      }
    } else {
      if (kDebugMode) {
        print('Failed to send data. Error: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Failed to send data. Error: ${response.body}');
      }
    }
  }
}
