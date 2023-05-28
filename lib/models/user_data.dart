import 'package:escurt/models/user_images_response.dart';

class UserDataModel {
  UserDataModel({
    this.id = 0,
    this.firstName = "",
    this.lastName = "",
    this.gender = "",
    this.bio = "",
    this.mobileNumberDialCode = "",
    this.mobileNumber = "",
    this.dateOfBirth = "",
    this.interests = "",
    this.onboardingStep = 0,
    this.age = 0,
    this.userImages = const [],
  });

  int id;
  String firstName;
  String lastName;
  String gender;
  String bio;
  String mobileNumberDialCode;
  String mobileNumber;
  String dateOfBirth;
  String interests;
  int onboardingStep;
  int age;

  List<UserImageResponseModel> userImages;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        gender: json["gender"] ?? "",
        bio: json["bio"] ?? "",
        mobileNumberDialCode: json["mobileNumberDialCode"] ?? "",
        mobileNumber: json["mobileNumber"] ?? "",
        dateOfBirth: json["dateOfBirth"] ?? "",
        interests: json["interests"] ?? "",
        onboardingStep: json["onboardingStep"] ?? 0,
        age: json["age"] ?? 0,
        id: json["id"] ?? 0,
        userImages: (json["userImages"] as List<dynamic>?)
                ?.map((e) => UserImageResponseModel.fromJson(e))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "bio": bio,
        "mobileNumberDialCode": mobileNumberDialCode,
        "mobileNumber": mobileNumber,
        "dateOfBirth": dateOfBirth,
        "interests": interests,
        "onboardingStep": onboardingStep,
        "age": age,
        "id": id,
        "userImages": userImages,
      };
}
