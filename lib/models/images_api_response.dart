import 'dart:io';

class UserImageResponseModel {
  UserImageResponseModel({
    this.id = 0,
    this.name = "",
    this.image,
  });

  int id;
  String name;
  File? image;

  factory UserImageResponseModel.fromJson(Map<String, dynamic> json) =>
      UserImageResponseModel(
        id: json["id"] ?? "",
        name: json["name"] ?? 0,
        image: json["image"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
