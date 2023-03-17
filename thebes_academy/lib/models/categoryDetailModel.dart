class CategoryDetailModel {
  Result? result;


  CategoryDetailModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }


}

class Result {
  String? sId;
  String? titleAr;
  String? descriptionAr;
  String? golesAr;
  String? coverImage;
  String? cloudinaryId;
  List<Images>? images;
  List<void>? multiCloudinaryId;
  String? createdAt;
  String? updatedAt;
  int? iV;



  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    titleAr = json['title_ar'];
    descriptionAr = json['description_ar'];
    golesAr = json['goles_ar'];
    coverImage = json['coverImage'];
    cloudinaryId = json['cloudinary_id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['multiCloudinary_id'] != null) {
      multiCloudinaryId = <Null>[];
      json['multiCloudinary_id'].forEach((v) {
        multiCloudinaryId!.add(v);
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