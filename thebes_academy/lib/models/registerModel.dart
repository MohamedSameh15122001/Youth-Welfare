class RegisterModel {
  String? message;
  Student? student;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    student =
        json['Student'] != null ? Student.fromJson(json['Student']) : null;
  }
}

class Student {
  String? fullName;
  int? code;
  String? email;
  String? phone;
  String? password;
  String? role;
  bool? isverified;
  String? emailToken;
  String? specializationAr;
  String? specializationEn;
  List<void>? activity;
  List<void>? trip;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Student.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    code = json['code'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    role = json['role'];
    isverified = json['Isverified'];
    emailToken = json['emailToken'];
    specializationAr = json['Specialization_ar'];
    specializationEn = json['Specialization_en'];
    if (json['activity'] != null) {
      activity = <Null>[];
      json['activity'].forEach((v) {
        activity!.add(v);
      });
    }
    if (json['trip'] != null) {
      trip = <Null>[];
      json['trip'].forEach((v) {
        trip!.add(v);
      });
    }
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
