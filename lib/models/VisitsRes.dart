class VisitsRes {
  VisitsRes({
    this.visitId,
    this.patientId,
    this.visitDate,
    this.diagnosis,
    this.pharmaceutical,
  });

  VisitsRes.fromJson(dynamic json) {
    visitId = json['visitId'];
    patientId = json['patientId'];
    visitDate = json['visitDate'];
    diagnosis = json['diagnosis'];
    pharmaceutical = json['pharmaceutical'];
  }

  int? visitId;
  String? patientId;
  String? visitDate;
  String? diagnosis;
  String? pharmaceutical;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['visitId'] = visitId;
    map['patientId'] = patientId;
    map['visitDate'] = visitDate;
    map['diagnosis'] = diagnosis;
    map['pharmaceutical'] = pharmaceutical;
    return map;
  }
}
