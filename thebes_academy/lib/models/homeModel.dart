class HomeModel {
  List<Result>? result;



  HomeModel.fromJson(Map<String, dynamic> json) {
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
  String? nameAr;
  String? descriptionAr;
  String? coverImage;
  String? cloudinaryId;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;
  int? iV;



  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nameAr = json['name_ar'];
    descriptionAr = json['description_ar'];
    coverImage = json['coverImage'];
    cloudinaryId = json['cloudinary_id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }


}

class Images {
  String? url;
  String? cloudinaryId;



  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    cloudinaryId = json['cloudinary_id'];
  }


}