class AddVisitRes {
  AddVisitRes({
    this.visitDate,
    this.diagnosis,
    this.pharmaceutical,
  });

  AddVisitRes.fromJson(dynamic json) {
    visitDate = json['visitDate'];
    diagnosis = json['diagnosis'];
    pharmaceutical = json['pharmaceutical'];
  }

  String? visitDate;
  String? diagnosis;
  String? pharmaceutical;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['visitDate'] = visitDate;
    map['diagnosis'] = diagnosis;
    map['pharmaceutical'] = pharmaceutical;
    return map;
  }
}
