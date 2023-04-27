class JwtTokenResponseModel {
  JwtTokenResponseModel({
    this.token = "",
    this.refreshToken = "",
    this.success,
    this.accessToken = "",
    this.securityStamp = "",
  });

  String token;
  String refreshToken;
  bool? success;
  String accessToken;
  String securityStamp;

  factory JwtTokenResponseModel.fromJson(Map<String, dynamic> json) =>
      JwtTokenResponseModel(
        token: json["token"] ?? "",
        refreshToken: json["refreshToken"] ?? "",
        success: json["success"] ?? "",
        accessToken: json["accessToken"] ?? "",
        securityStamp: json["securityStamp"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "refreshToken": refreshToken,
        "success": success,
        "accessToken": accessToken,
        "securityStamp": securityStamp,
      };
}
