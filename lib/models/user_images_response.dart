class UserImageResponseModel {
  UserImageResponseModel({
    this.id = 0,
    this.name = "",
    this.apiUserId = 0,
    this.base64 = "",
    this.contentType = "",
  });

  int id;
  String name;
  String contentType;
  String base64;
  int apiUserId;

  factory UserImageResponseModel.fromJson(Map<String, dynamic> json) =>
      UserImageResponseModel(
        id: json["id"] ?? "",
        name: json["name"] ?? 0,
        contentType: json["contentType"] ?? "",
        base64: json["base64"] ?? "",
        apiUserId: json["apiUserId"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contentType": contentType,
        "base64": base64,
        "apiUserId": apiUserId,
      };
}
