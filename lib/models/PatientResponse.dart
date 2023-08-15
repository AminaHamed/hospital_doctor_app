class PatientResponse {
  PatientResponse({
    this.nid,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.gender,
    this.age,
    this.address,
  });

  PatientResponse.fromJson(dynamic json) {
    nid = json['nid'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
    address = json['address'];
  }

  String? nid;
  String? fullName;
  String? phoneNumber;
  String? email;
  String? gender;
  int? age;
  String? address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nid'] = nid;
    map['fullName'] = fullName;
    map['phoneNumber'] = phoneNumber;
    map['email'] = email;
    map['gender'] = gender;
    map['age'] = age;
    map['address'] = address;
    return map;
  }
}
