class AddChronicRes {
  AddChronicRes({
    this.patientId,
    this.diseaseName,
    this.treatingMedicines,
  });

  AddChronicRes.fromJson(dynamic json) {
    patientId = json['patientId'];
    diseaseName = json['diseaseName'];
    treatingMedicines = json['treatingMedicines'];
  }

  String? patientId;
  String? diseaseName;
  String? treatingMedicines;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientId'] = patientId;
    map['diseaseName'] = diseaseName;
    map['treatingMedicines'] = treatingMedicines;
    return map;
  }
}
