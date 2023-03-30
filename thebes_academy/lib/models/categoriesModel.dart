class CategoriesModel {
  List<Result>? result;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
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
    titleAr = json['title_ar'] ?? json['title_en'];
    descriptionAr = json['description_ar'] ?? json['description_en'];
    golesAr = json['goles_ar'] ?? json['goles_en'];
    coverImage = json['coverImage'];
    cloudinaryId = json['cloudinary_id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['multiCloudinary_id'] != null) {
      multiCloudinaryId = <void>[];
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
