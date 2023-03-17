class ActivityDetailModel {
  Result? result;



  ActivityDetailModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }


}

class Result {
  String? sId;
  String? titleAr;
  String? descriptionAr;
  String? coverImage;
  String? cloudinaryId;
  List<Images>? images;
  int? numRecorded;
  int? ratingCount;
  String? category;
  String? createdAt;
  String? updatedAt;
  int? iV;


  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    titleAr = json['title_ar'];
    descriptionAr = json['description_ar'];
    coverImage = json['coverImage'];
    cloudinaryId = json['cloudinary_id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    numRecorded = json['numRecorded'];
    ratingCount = json['ratingCount'];
    category = json['category'];
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