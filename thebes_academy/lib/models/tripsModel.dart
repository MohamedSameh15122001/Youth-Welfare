class TripsModel {
  List<Result>? result;



  TripsModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

}

class Result {
  String? sId;
  String? titleAr;
  String? descriptionAr;
  String? image;
  int? price;
  String? placeAr;
  String? date;
  String? createdAt;
  String? updatedAt;
  int? iV;



  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    titleAr = json['title_ar'] ?? json['title_en'];
    descriptionAr = json['description_ar'] ?? json['description_en'];
    image = json['image'];
    price = json['price'];
    placeAr = json['place_ar'] ?? json['place_en'];
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }


}