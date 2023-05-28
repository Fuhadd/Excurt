class UserImageResponseModel {
  UserImageResponseModel({
    this.id = 0,
    this.name = "",
    this.apiUserId = 0,
    this.imageUrl = "",
    this.imageSize = 0,
  });

  int id;
  String name;
  int imageSize;
  String imageUrl;
  int apiUserId;

  factory UserImageResponseModel.fromJson(Map<String, dynamic> json) =>
      UserImageResponseModel(
        id: json["id"] ?? "",
        name: json["name"] ?? 0,
        imageSize: json["imageSize"] ?? 0,
        imageUrl: json["imageUrl"] ?? "",
        apiUserId: json["apiUserId"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageSize": imageSize,
        "imageUrl": imageUrl,
        "apiUserId": apiUserId,
      };
}

class UserImageRequestModel {
  UserImageRequestModel({
    this.name = "",
    this.imageUrl = "",
    this.imageSize = 0,
  });

  String name;
  int imageSize;
  String imageUrl;

  factory UserImageRequestModel.fromJson(Map<String, dynamic> json) =>
      UserImageRequestModel(
        name: json["name"] ?? 0,
        imageSize: json["imageSize"] ?? 0,
        imageUrl: json["imageUrl"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageSize": imageSize,
        "imageUrl": imageUrl,
      };
}
