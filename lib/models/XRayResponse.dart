/// xRayId : 1
/// patientId : "123456789"
/// xRayImage : "xray_image_path_or_base64_data1"
/// notes : "X-ray notes for John Doe"
/// xRayDate : "2023-07-25T00:00:00"

class XRayResponse {
  XRayResponse({
    this.xRayId,
    this.patientId,
    this.xRayImage,
    this.notes,
    this.xRayDate,
  });

  XRayResponse.fromJson(dynamic json) {
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

  XRayResponse copyWith({
    num? xRayId,
    String? patientId,
    String? xRayImage,
    String? notes,
    String? xRayDate,
  }) =>
      XRayResponse(
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
