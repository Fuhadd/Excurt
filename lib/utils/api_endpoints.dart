class ApiEndpoints {
  //UserIdentity
  static const weatherForcast = "WeatherForecast";
  static const register = "UserIdentity/create-user";
  static const signIn = "UserIdentity/login";
  static const uploadMobileNumber = "UserIdentity/upload-mobile-number";
  static const uploadUserName = "UserIdentity/upload_user-name";
  static const uploadDateOfBirth = "UserIdentity/upload_user-birthday";
  static const uploadGender = "UserIdentity/upload_user-gender";
  static const uploadUserImage = "UserIdentity/upload-single-user-image";
  static const deleteUserImage = "UserIdentity/delete-user-image";
  static const uploadUserInterests = "UserIdentity/upload_user-interests";

  //MATCHES
  static const getUsersForMatching = "Matches/get-all-users-for-matching";
}
