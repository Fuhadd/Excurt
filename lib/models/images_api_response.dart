import 'dart:io';

class UserImageApiResponseModel {
  UserImageApiResponseModel({
    this.id = 0,
    this.name = "",
    this.image,
  });

  int id;
  String name;
  File? image;

  factory UserImageApiResponseModel.fromJson(Map<String, dynamic> json) =>
      UserImageApiResponseModel(
        id: json["id"] ?? "",
        name: json["name"] ?? 0,
        image: json["image"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
