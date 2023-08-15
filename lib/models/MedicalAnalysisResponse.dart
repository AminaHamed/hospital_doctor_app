/// analysisId : 1
/// patientId : "123456789"
/// analysisImage : "image_path_or_base64_data1"
/// notes : "Medical analysis notes for John Doe"
/// analysisDate : "2023-07-25T00:00:00"

class MedicalAnalysisResponse {
  MedicalAnalysisResponse({
    this.analysisId,
    this.patientId,
    this.analysisImage,
    this.notes,
    this.analysisDate,
  });

  MedicalAnalysisResponse.fromJson(dynamic json) {
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

  MedicalAnalysisResponse copyWith({
    num? analysisId,
    String? patientId,
    String? analysisImage,
    String? notes,
    String? analysisDate,
  }) =>
      MedicalAnalysisResponse(
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
