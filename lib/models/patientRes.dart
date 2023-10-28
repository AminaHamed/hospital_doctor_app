class PatientRes {
  PatientRes({
    this.nid,
    this.fullName,
    this.phoneNumber,
    this.gender,
    this.age,
  });

  PatientRes.fromJson(dynamic json) {
    nid = json['nid'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    age = json['age'];
  }

  String? nid;
  String? fullName;
  String? phoneNumber;
  String? gender;
  int? age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nid'] = nid;
    map['fullName'] = fullName;
    map['phoneNumber'] = phoneNumber;
    map['gender'] = gender;
    map['age'] = age;
    return map;
  }
}
