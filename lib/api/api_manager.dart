import 'dart:convert';

import 'package:hospital_app/models/AddVisitRes.dart';
import 'package:hospital_app/models/MedicalAnalysisResponse.dart';
import 'package:hospital_app/models/PatientResponse.dart';
import 'package:hospital_app/models/VisitsRes.dart';
import 'package:http/http.dart' as http;

import '../models/PatientInformation.dart';

class ApiManager {
  static const String baseUrl = "momahgoub172-001-site1.atempurl.com";

  static Future<http.Response?> addVisit(
      String id, AddVisitRes addVisitRes) async {
    String apiUrl =
        'http://momahgoub172-001-site1.atempurl.com/api/PreviousVisits/AddVisit?PatientId=$id';
    try {
      // Map<String, dynamic> map = addVisitRes.toJson();
      List<Map<String, dynamic>> data = [
        {
          "visitDate": addVisitRes.visitDate.toString(),
          "diagnosis": addVisitRes.pharmaceutical.toString(),
          "pharmaceutical": addVisitRes.diagnosis.toString()
        }
      ];
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
      //no user with this id
      return 'no user with this id';
    } else if (response.statusCode == 400) {
      return 'The nid field is required';
    } else {
      return throw Exception('Failed to load Patient try again later');
    }
  }

  static Future<PatientResponse> getPatientData(String ID) async {
    final response = await http.get(Uri.parse(
        'http://momahgoub172-001-site1.atempurl.com/api/Patient/GetPatientByNID?nid=$ID'));
    // if (response.statusCode == 200) {

    return PatientResponse.fromJson(jsonDecode(response.body));
    // } else {
    //   return throw Exception('Failed to load Patient try again later');
    // }
  }

  static Future<MedicalAnalysisResponse> getMedicalAnalysisData(
      String ID) async {
    final response = await http.get(Uri.parse(
        "http://momahgoub172-001-site1.atempurl.com/api/MedicalAnalysis/GetMedicalAnalysesByPatientNID?nid=$ID"));

    if (response.statusCode == 200) {
      return MedicalAnalysisResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  static sendMedicalAnalysis(MedicalAnalysis object) async {
    Map<String, dynamic> map = object.toJson();
    String jsonData = json.encode(map);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String apiUrl =
        'http://momahgoub172-001-site1.atempurl.com/api/MedicalAnalysis/AddMedicalAnalysis';
    http.Response response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: jsonData);
    if (response.statusCode == 200) {
      print('Data sent successfully!');
    } else {
      print('Failed to send data. Error: ${response.statusCode}');
    }
  }
}
