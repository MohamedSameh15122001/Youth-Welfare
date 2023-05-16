// ignore_for_file: unnecessary_question_mark, prefer_void_to_null

class ProfileModel {
  Student? student;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    student =
        json['Student'] != null ? Student.fromJson(json['Student']) : null;
  }
}

class Student {
  String? sId;
  String? fullName;
  String? image;
  String? cloudinaryId;
  int? code;
  String? email;
  String? phone;
  String? password;
  String? role;
  bool? isverified;
  Null? emailToken;
  String? specialization;
  List<Activity>? activity;
  List<Trip>? trip;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Student.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    image = json['image'];
    cloudinaryId = json['cloudinary_id'];
    code = json['code'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    role = json['role'];
    isverified = json['Isverified'];
    emailToken = json['emailToken'];
    specialization = json['Specialization'];
    if (json['activity'] != null) {
      activity = <Activity>[];
      json['activity'].forEach((v) {
        activity!.add(Activity.fromJson(v));
      });
    }
    if (json['trip'] != null) {
      trip = <Trip>[];
      json['trip'].forEach((v) {
        trip!.add(Trip.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class Activity {
  String? titleAr;
  String? titleEn;

  Activity.fromJson(Map<String, dynamic> json) {
    titleAr = json['title_ar'];
    titleEn = json['title_en'];
  }
}

class Trip {
  String? titleAr;
  String? titleEn;

  Trip.fromJson(Map<String, dynamic> json) {
    titleAr = json['title_ar'];
    titleEn = json['title_en'];
  }
}
