/// visitId : 98
/// patientId : "7890"
/// visitDate : "2023-08-24T01:52:36.593"
/// pharma : [{"id":84,"diagnosis":"lpm","pharmaceutical":"kom","visitId":98}]

class VisitsRes {
  VisitsRes({
    this.visitId,
    this.patientId,
    this.visitDate,
    this.pharma,
  });

  VisitsRes.fromJson(dynamic json) {
    visitId = json['visitId'];
    patientId = json['patientId'];
    visitDate = json['visitDate'];
    if (json['pharma'] != null) {
      pharma = [];
      json['pharma'].forEach((v) {
        pharma?.add(Pharma.fromJson(v));
      });
    }
  }

  num? visitId;
  String? patientId;
  String? visitDate;
  List<Pharma>? pharma;

  VisitsRes copyWith({
    num? visitId,
    String? patientId,
    String? visitDate,
    List<Pharma>? pharma,
  }) =>
      VisitsRes(
        visitId: visitId ?? this.visitId,
        patientId: patientId ?? this.patientId,
        visitDate: visitDate ?? this.visitDate,
        pharma: pharma ?? this.pharma,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['visitId'] = visitId;
    map['patientId'] = patientId;
    map['visitDate'] = visitDate;
    if (pharma != null) {
      map['pharma'] = pharma?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 84
/// diagnosis : "lpm"
/// pharmaceutical : "kom"
/// visitId : 98

class Pharma {
  Pharma({
    this.id,
    this.diagnosis,
    this.pharmaceutical,
    this.visitId,
  });

  Pharma.fromJson(dynamic json) {
    id = json['id'];
    diagnosis = json['diagnosis'];
    pharmaceutical = json['pharmaceutical'];
    visitId = json['visitId'];
  }

  num? id;
  String? diagnosis;
  String? pharmaceutical;
  num? visitId;

  Pharma copyWith({
    num? id,
    String? diagnosis,
    String? pharmaceutical,
    num? visitId,
  }) =>
      Pharma(
        id: id ?? this.id,
        diagnosis: diagnosis ?? this.diagnosis,
        pharmaceutical: pharmaceutical ?? this.pharmaceutical,
        visitId: visitId ?? this.visitId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['diagnosis'] = diagnosis;
    map['pharmaceutical'] = pharmaceutical;
    map['visitId'] = visitId;
    return map;
  }
}
