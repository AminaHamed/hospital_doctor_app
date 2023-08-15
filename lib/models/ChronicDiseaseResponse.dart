class ChronicDiseaseResponse {
  ChronicDiseaseResponse({
    this.diseaseId,
    this.patientId,
    this.diseaseName,
    this.diagnosisDate,
    this.treatingMedicines,
  });

  ChronicDiseaseResponse.fromJson(dynamic json) {
    diseaseId = json['diseaseId'];
    patientId = json['patientId'];
    diseaseName = json['diseaseName'];
    diagnosisDate = json['diagnosisDate'];
    treatingMedicines = json['treatingMedicines'];
  }

  int? diseaseId;
  String? patientId;
  String? diseaseName;
  String? diagnosisDate;
  String? treatingMedicines;

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
