class EnrollModel {
  int? status;
  String? message;

  EnrollModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }


}