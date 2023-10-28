/// patient : {"nid":"987654321","fullName":"Jane Smith","phoneNumber":"9876543210","email":"test2@mail.com","gender":"Female","age":25,"address":"456 Elm St","userId":null,"user":null}
/// xRay : [{"xRayId":2,"patientId":"987654321","xRayImage":"xray_image_path_or_base64_data2","notes":"X-ray notes for Jane Smith","xRayDate":"2023-07-24T00:00:00"}]
/// medicalAnalysis : [{"analysisId":2,"patientId":"987654321","analysisImage":"image_path_or_base64_data2","notes":"Medical analysis notes for Jane Smith","analysisDate":"2023-07-24T00:00:00"}]
/// chronicDisease : [{"diseaseId":2,"patientId":"987654321","diseaseName":"Asthma","diagnosisDate":"2023-07-24T00:00:00","treatingMedicines":"Albuterol"}]

class PatientInformation {
  PatientInformation({
    this.patient,
    this.xRay,
    this.medicalAnalysis,
    this.chronicDisease,
  });

  PatientInformation.fromJson(dynamic json) {
    patient =
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    if (json['xRay'] != null) {
      xRay = [];
      json['xRay'].forEach((v) {
        xRay?.add(XRay.fromJson(v));
      });
    }
    if (json['medicalAnalysis'] != null) {
      medicalAnalysis = [];
      json['medicalAnalysis'].forEach((v) {
        medicalAnalysis?.add(MedicalAnalysis.fromJson(v));
      });
    }
    if (json['chronicDisease'] != null) {
      chronicDisease = [];
      json['chronicDisease'].forEach((v) {
        chronicDisease?.add(ChronicDisease.fromJson(v));
      });
    }
  }

  Patient? patient;
  List<XRay>? xRay;
  List<MedicalAnalysis>? medicalAnalysis;
  List<ChronicDisease>? chronicDisease;

  PatientInformation copyWith({
    Patient? patient,
    List<XRay>? xRay,
    List<MedicalAnalysis>? medicalAnalysis,
    List<ChronicDisease>? chronicDisease,
  }) =>
      PatientInformation(
        patient: patient ?? this.patient,
        xRay: xRay ?? this.xRay,
        medicalAnalysis: medicalAnalysis ?? this.medicalAnalysis,
        chronicDisease: chronicDisease ?? this.chronicDisease,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (patient != null) {
      map['patient'] = patient?.toJson();
    }
    if (xRay != null) {
      map['xRay'] = xRay?.map((v) => v.toJson()).toList();
    }
    if (medicalAnalysis != null) {
      map['medicalAnalysis'] = medicalAnalysis?.map((v) => v.toJson()).toList();
    }
    if (chronicDisease != null) {
      map['chronicDisease'] = chronicDisease?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// diseaseId : 2
/// patientId : "987654321"
/// diseaseName : "Asthma"
/// diagnosisDate : "2023-07-24T00:00:00"
/// treatingMedicines : "Albuterol"

class ChronicDisease {
  ChronicDisease({
    this.diseaseId,
    this.patientId,
    this.diseaseName,
    this.diagnosisDate,
    this.treatingMedicines,
  });

  ChronicDisease.fromJson(dynamic json) {
    diseaseId = json['diseaseId'];
    patientId = json['patientId'];
    diseaseName = json['diseaseName'];
    diagnosisDate = json['diagnosisDate'];
    treatingMedicines = json['treatingMedicines'];
  }

  num? diseaseId;
  String? patientId;
  String? diseaseName;
  String? diagnosisDate;
  String? treatingMedicines;

  ChronicDisease copyWith({
    num? diseaseId,
    String? patientId,
    String? diseaseName,
    String? diagnosisDate,
    String? treatingMedicines,
  }) =>
      ChronicDisease(
        diseaseId: diseaseId ?? this.diseaseId,
        patientId: patientId ?? this.patientId,
        diseaseName: diseaseName ?? this.diseaseName,
        diagnosisDate: diagnosisDate ?? this.diagnosisDate,
        treatingMedicines: treatingMedicines ?? this.treatingMedicines,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['diseaseId'] = diseaseId;
    map['patientId'] = patientId;
    map['diseaseName'] = diseaseName;
    map['diagnosisDate'] = diagnosisDate;
    map['treatingMedicines'] = treatingMedicines;
    return map;
  }
}

/// analysisId : 2
/// patientId : "987654321"
/// analysisImage : "image_path_or_base64_data2"
/// notes : "Medical analysis notes for Jane Smith"
/// analysisDate : "2023-07-24T00:00:00"

class MedicalAnalysis {
  MedicalAnalysis({
    this.analysisId,
    this.patientId,
    this.analysisImage,
    this.notes,
    this.analysisDate,
  });

  MedicalAnalysis.fromJson(dynamic json) {
    analysisId = json['analysisId'];
    patientId = json['patientId'];
    analysisImage = json['analysisImage'];
    notes = json['notes'];
    analysisDate = json['analysisDate'];
  }

  num? analysisId;
  String? patientId;
  String? analysisImage;
  String? notes;
  String? analysisDate;

  MedicalAnalysis copyWith({
    num? analysisId,
    String? patientId,
    String? analysisImage,
    String? notes,
    String? analysisDate,
  }) =>
      MedicalAnalysis(
        analysisId: analysisId ?? this.analysisId,
        patientId: patientId ?? this.patientId,
        analysisImage: analysisImage ?? this.analysisImage,
        notes: notes ?? this.notes,
        analysisDate: analysisDate ?? this.analysisDate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['analysisId'] = analysisId;
    map['patientId'] = patientId;
    map['analysisImage'] = analysisImage;
    map['notes'] = notes;
    map['analysisDate'] = analysisDate;
    return map;
  }
}

/// xRayId : 2
/// patientId : "987654321"
/// xRayImage : "xray_image_path_or_base64_data2"
/// notes : "X-ray notes for Jane Smith"
/// xRayDate : "2023-07-24T00:00:00"

class XRay {
  XRay({
    this.xRayId,
    this.patientId,
    this.xRayImage,
    this.notes,
    this.xRayDate,
  });

  XRay.fromJson(dynamic json) {
    xRayId = json['xRayId'];
    patientId = json['patientId'];
    xRayImage = json['xRayImage'];
    notes = json['notes'];
    xRayDate = json['xRayDate'];
  }

  num? xRayId;
  String? patientId;
  String? xRayImage;
  String? notes;
  String? xRayDate;

  XRay copyWith({
    num? xRayId,
    String? patientId,
    String? xRayImage,
    String? notes,
    String? xRayDate,
  }) =>
      XRay(
        xRayId: xRayId ?? this.xRayId,
        patientId: patientId ?? this.patientId,
        xRayImage: xRayImage ?? this.xRayImage,
        notes: notes ?? this.notes,
        xRayDate: xRayDate ?? this.xRayDate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['xRayId'] = xRayId;
    map['patientId'] = patientId;
    map['xRayImage'] = xRayImage;
    map['notes'] = notes;
    map['xRayDate'] = xRayDate;
    return map;
  }
}

/// nid : "987654321"
/// fullName : "Jane Smith"
/// phoneNumber : "9876543210"
/// email : "test2@mail.com"
/// gender : "Female"
/// age : 25
/// address : "456 Elm St"
/// userId : null
/// user : null

class Patient {
  Patient({
    this.nid,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.gender,
    this.age,
    this.address,
    this.userId,
    this.user,
  });

  Patient.fromJson(dynamic json) {
    nid = json['nid'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
    address = json['address'];
    userId = json['userId'];
    user = json['user'];
  }

  String? nid;
  String? fullName;
  String? phoneNumber;
  String? email;
  String? gender;
  num? age;
  String? address;
  dynamic userId;
  dynamic user;

  Patient copyWith({
    String? nid,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? gender,
    num? age,
    String? address,
    dynamic userId,
    dynamic user,
  }) =>
      Patient(
        nid: nid ?? this.nid,
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        address: address ?? this.address,
        userId: userId ?? this.userId,
        user: user ?? this.user,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nid'] = nid;
    map['fullName'] = fullName;
    map['phoneNumber'] = phoneNumber;
    map['email'] = email;
    map['gender'] = gender;
    map['age'] = age;
    map['address'] = address;
    map['userId'] = userId;
    map['user'] = user;
    return map;
  }
}
