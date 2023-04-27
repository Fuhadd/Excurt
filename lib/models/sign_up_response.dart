import 'package:escurt/models/jwt_token_response.dart';

class RegisterResponseModel {
  RegisterResponseModel({
    this.email = "",
    this.onboardingStep = 0,
    this.jwtToken,
  });

  String email;
  int onboardingStep;
  JwtTokenResponseModel? jwtToken;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        email: json["email"] ?? "",
        onboardingStep: json["onboardingStep"] ?? 0,
        jwtToken: JwtTokenResponseModel.fromJson(json["jwtToken"] ?? ""),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "onboardingStep": onboardingStep,
        "jwtToken": jwtToken,
      };
}
