class UserImageResponseModel {
  UserImageResponseModel({
    this.id = 0,
    this.name = "",
  });

  int id;
  String name;

  factory UserImageResponseModel.fromJson(Map<String, dynamic> json) =>
      UserImageResponseModel(
        id: json["id"] ?? "",
        name: json["name"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
