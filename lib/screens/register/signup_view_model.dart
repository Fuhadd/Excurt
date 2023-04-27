import 'dart:async';
import 'package:escurt/models/user_data.dart';
import 'package:escurt/screens/dashboard/dashboard_screen.dart';
import 'package:escurt/screens/register/signup_dob_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../Constants/custom_string.dart';
import '../../data/view_model/base_change_notifier.dart';
import '../../models/jwt_token_response.dart';
import '../../models/sign_up_response.dart';
import 'signup_gender_screen.dart';
import 'signup_image_screen.dart';
import 'signup_name_screen.dart';
import 'signup_otp_screen.dart';
import 'signup_phone_screen.dart';

final signupProvider =
    ChangeNotifierProvider.autoDispose<SignupViewModel>((ref) {
  return SignupViewModel.initWhoAmI();
});

class SignupViewModel extends BaseChangeNotifier {
  bool _isloading;
  bool _isimageLoading;
  String authorized = 'Not Authorized';

  SignupViewModel.initWhoAmI()
      : _isloading = false,
        _isimageLoading = false,
        _phoneNumber = "",
        _userId = "",
        _userImageId = 0,
        _userFirstName = "",
        _password = "",
        _email = "";
  SignupViewModel.profile()
      : _phoneNumber = "",
        _userId = "",
        _userImageId = 0,
        _userFirstName = "",
        _email = "",
        _password = "",
        _isimageLoading = false,
        _isloading = false;

  bool get isImageLoading => _isimageLoading;
  bool get isLoading => _isloading;
  String _email, _phoneNumber, _userId, _userFirstName, _password = "";
  int _userImageId;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get password => _password;
  String get userId => _userId;
  int get userImageId => _userImageId;
  String get userFirstName => _userFirstName;

  set isLoading(bool isloading) {
    _isloading = isloading;
    notifyListeners();
  }

  set isImageLoading(bool isimageLoading) {
    _isimageLoading = isimageLoading;
    notifyListeners();
  }

  Future<void> signIn(email, password, {BuildContext? context}) async {
    try {
      isLoading = true;
      final res = await userRepository.signIn(
        email,
        password,
      );

      if (res.success) {
        _email = email;
        isLoading = false;
        var data = JwtTokenResponseModel.fromJson(res.data);
        navigationHandler.pushNamed(
          DashboardScreen.routeName,
        );
        localCache.saveToken(data.token);
      } else {
        isLoading = false;
        print(res.errors);
        ScaffoldMessenger.of(context!)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(res.errors!.join('\n')),
            backgroundColor: Colors.red,
          ));

        // GenericDialog().showSimplePopup(
        //   type: InfoBoxType.warning,
        //   title: ConstantString.apiErrorResponseTitle,
        //   content: res.message,
        // );
      }
    } catch (e, stacktrace) {
      isLoading = false;
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future<void> signUpEmailAndPassword(email, password,
      {BuildContext? context}) async {
    try {
      isLoading = true;
      final res = await userRepository.signUpEmailAndPassword(
        email,
        password,
      );

      if (res.success) {
        _email = email;
        isLoading = false;
        var data = RegisterResponseModel.fromJson(res.data);
        navigationHandler.pushNamed(SignupPhoneScreen.routeName, arg: {
          'email': data.email,
        });
        localCache.saveToken(data.jwtToken!.token);
        localCache.saveToLocalCache(
            key: ConstantString.onboardingStep, value: data.onboardingStep);
      } else {
        isLoading = false;
        print(res.errors);
        ScaffoldMessenger.of(context!)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(res.errors!.join('\n')),
            backgroundColor: Colors.red,
          ));

        // GenericDialog().showSimplePopup(
        //   type: InfoBoxType.warning,
        //   title: ConstantString.apiErrorResponseTitle,
        //   content: res.message,
        // );
      }
    } catch (e, stacktrace) {
      isLoading = false;
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future<void> sendOtp(mobileNumberDialCode, mobileNumber,
      {BuildContext? context}) async {
    try {
      isLoading = true;
      final res =
          await userRepository.sendOtp(mobileNumberDialCode, mobileNumber);

      if (res.success) {
        _phoneNumber = phoneNumber;
        isLoading = false;
        navigationHandler.pushNamed(SignupOtpScreen.routeName, arg: {
          'otpMessage': res.message,
          'mobileNumber': mobileNumber,
          'mobileNumberDialCode': mobileNumberDialCode
        });
      } else {
        isLoading = false;
        print(res.errors);
        ScaffoldMessenger.of(context!)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(res.errors!.join('\n')),
            backgroundColor: Colors.red,
          ));

        // GenericDialog().showSimplePopup(
        //   type: InfoBoxType.warning,
        //   title: ConstantString.apiErrorResponseTitle,
        //   content: res.message,
        // );
      }
    } catch (e, stacktrace) {
      isLoading = false;
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future<void> uploadPhoneNumber(mobileNumberDialCode, mobileNumber, otp,
      {BuildContext? context}) async {
    try {
      isLoading = true;
      final res = await userRepository.uploadPhoneNumber(
          mobileNumberDialCode, mobileNumber, otp);

      if (res.success) {
        _phoneNumber = phoneNumber;
        isLoading = false;
        navigationHandler.pushNamed(SignupNameScreen.routeName, arg: {
          'otpMessage': res.message,
        });
      } else {
        isLoading = false;
        print(res.errors);
        ScaffoldMessenger.of(context!)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(res.errors!.join('\n')),
            backgroundColor: Colors.red,
          ));

        // GenericDialog().showSimplePopup(
        //   type: InfoBoxType.warning,
        //   title: ConstantString.apiErrorResponseTitle,
        //   content: res.message,
        // );
      }
    } catch (e, stacktrace) {
      isLoading = false;
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future<void> uploadUserName(firstName, lastName,
      {BuildContext? context}) async {
    try {
      isLoading = true;
      final res = await userRepository.uploadUserName(
        firstName,
        lastName,
      );

      if (res.success) {
        isLoading = false;
        navigationHandler.pushNamed(
          SignupDOBScreen.routeName,
        );
      } else {
        isLoading = false;
        print(res.errors);
        ScaffoldMessenger.of(context!)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(res.errors!.join('\n')),
            backgroundColor: Colors.red,
          ));

        // GenericDialog().showSimplePopup(
        //   type: InfoBoxType.warning,
        //   title: ConstantString.apiErrorResponseTitle,
        //   content: res.message,
        // );
      }
    } catch (e, stacktrace) {
      isLoading = false;
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future<void> uploadDateOfBirth(dateOfBirth, {BuildContext? context}) async {
    try {
      isLoading = true;
      final res = await userRepository.uploadDateOfBirth(
        dateOfBirth,
      );

      if (res.success) {
        isLoading = false;
        navigationHandler.pushNamed(
          SignupGenderScreen.routeName,
        );
      } else {
        isLoading = false;
        print(res.errors);
        ScaffoldMessenger.of(context!)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(res.errors!.join('\n')),
            backgroundColor: Colors.red,
          ));

        // GenericDialog().showSimplePopup(
        //   type: InfoBoxType.warning,
        //   title: ConstantString.apiErrorResponseTitle,
        //   content: res.message,
        // );
      }
    } catch (e, stacktrace) {
      isLoading = false;
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future<void> uploadGender(gender, {BuildContext? context}) async {
    try {
      isLoading = true;
      final res = await userRepository.uploadGender(
        gender,
      );

      if (res.success) {
        isLoading = false;
        navigationHandler.pushNamed(
          SignupImageScreen.routeName,
        );
      } else {
        isLoading = false;
        print(res.errors);
        ScaffoldMessenger.of(context!)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(res.errors!.join('\n')),
            backgroundColor: Colors.red,
          ));
        // GenericDialog().showSimplePopup(
        //   type: InfoBoxType.warning,
        //   title: ConstantString.apiErrorResponseTitle,
        //   content: res.message,
        // );
      }
    } catch (e, stacktrace) {
      isLoading = false;
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future<void> uploadUserImage(String name, String contentType, String base64,
      {BuildContext? context}) async {
    try {
      isImageLoading = true;
      final res = await userRepository.uploadUserImage(
        name,
        contentType,
        base64,
      );

      if (res.success) {
        isImageLoading = false;
        var data = UserDataModel.fromJson(res.data);
        _userImageId = data.userImages[0].id;

        // navigationHandler.pushNamed(
        //   SignupImageScreen.routeName,
        // );
      } else {
        isImageLoading = false;
        print(res.errors);
        ScaffoldMessenger.of(context!)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(res.errors!.join('\n')),
            backgroundColor: Colors.red,
          ));

        // GenericDialog().showSimplePopup(
        //   type: InfoBoxType.warning,
        //   title: ConstantString.apiErrorResponseTitle,
        //   content: res.message,
        // );
      }
    } catch (e, stacktrace) {
      isImageLoading = false;
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future<void> deleteUserImage(int imageId, {BuildContext? context}) async {
    try {
      isImageLoading = true;
      final res = await userRepository.deleteUserImage(
        imageId,
      );

      if (res.success) {
        isImageLoading = false;

        // navigationHandler.pushNamed(
        //   SignupImageScreen.routeName,
        // );
      } else {
        isImageLoading = false;
        print(res.errors);
        ScaffoldMessenger.of(context!)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(res.errors!.join('\n')),
            backgroundColor: Colors.red,
          ));

        // GenericDialog().showSimplePopup(
        //   type: InfoBoxType.warning,
        //   title: ConstantString.apiErrorResponseTitle,
        //   content: res.message,
        // );
      }
    } catch (e, stacktrace) {
      isImageLoading = false;
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future<void> uploadUserInterests(interests, {BuildContext? context}) async {
    try {
      isLoading = true;
      final res = await userRepository.uploadUserInterests(
        interests,
      );

      if (res.success) {
        isLoading = false;
        navigationHandler.pushNamed(
          DashboardScreen.routeName,
        );
      } else {
        isLoading = false;
        print(res.errors);
        ScaffoldMessenger.of(context!)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(res.errors!.join('\n')),
            backgroundColor: Colors.red,
          ));

        // GenericDialog().showSimplePopup(
        //   type: InfoBoxType.warning,
        //   title: ConstantString.apiErrorResponseTitle,
        //   content: res.message,
        // );
      }
    } catch (e, stacktrace) {
      isLoading = false;
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  // Future<void> signUpName(String firstName, lastName) async {
  //   try {
  //     isLoading = true;
  //     final res = await userRepository.signUpName(firstName, lastName,);
  //     if (res.success) {
  //       isLoading = false;
  //       var data = RegisterResponseModel.fromJson(res.data);

  //       navigationHandler.pushNamed(SignUpPassword.id,
  //           arg: {'onboardingType': OnboardingType.newCustomer});

  //       localCache.saveToken(data.accessToken);
  //       localCache.saveToLocalCache(
  //           key: ConstantString.onboardingSessionId, value: data.sessionId);

  //       localCache.removeFromLocalCache(ConstantString.kycInfo);
  //       localCache.removeFromLocalCache(ConstantString.isBioDataUpdated);
  //       localCache.removeFromLocalCache(ConstantString.isAvatarUpdated);
  //       localCache.removeFromLocalCache(ConstantString.saveUserId);
  //     } else {
  //       isLoading = false;
  //       GenericDialog().showSimplePopup(
  //         type: InfoBoxType.warning,
  //         title: ConstantString.apiErrorResponseTitle,
  //         content: res.message,
  //       );
  //     }
  //   } catch (e, stacktrace) {
  //     isLoading = false;
  //     debugPrint(e.toString());
  //     log(e.toString());
  //     log(stacktrace.toString());
  //   }
  // }

  // Future<void> signUp3(String password,
  //     {bool isBiometric = false, required WidgetRef ref}) async {
  //   try {
  //     isLoading = true;
  //     var key = generateUserKey();
  //     final res = await userRepository.signUp3(
  //         password,
  //         Platform.isIOS ? iosInfo : androidInfo,
  //         locator<LocalCache>()
  //             .getFromLocalCache(ConstantString.messagingToken)
  //             .toString(),
  //         isBiometric: isBiometric,
  //         key: key);
  //     if (res.succeeded) {
  //       var data = RegisterResponseModel.fromJson(res.data);
  //       var userData = UserData.fromJson(decodeUserData(data.accessToken));
  //       localCache.cacheUserData(value: json.encode(userData));
  //       localCache.saveToLocalCache(key: ConstantString.userKey, value: key);

  //       localCache.saveToken(data.accessToken);
  //       localCache.saveToLocalCache(
  //           key: ConstantString.onboardingSessionId, value: data.sessionId);

  //       localCache.removeFromLocalCache(ConstantString.kycInfo);
  //       if (isBiometric) {
  //         localCache.saveToLocalCache(
  //             key: ConstantString.enableBiometricSignIn, value: true);
  //         await ref.read(onboardingProfileProvider).registerDevice();
  //       }
  //       showDialog(
  //         context: navigationHandler.navigatorKey.currentContext!,
  //         builder: (context) {
  //           return FullScreenLoader(
  //             username: userData.firstname,
  //           );
  //         },
  //         barrierDismissible: false,
  //       );
  //       await DashBoardViewModel().getData().whenComplete(() {
  //         //  startLogoutTimer();
  //         isBiometricsLoading = false;
  //         ref.read(dashboardLoadedProvider.notifier).state = true;
  //         isLoading = false;
  //         ref.read(sessionHasExpired.notifier).state = false;
  //         InactivityRedirect().handleUserSession();
  //       });
  //     } else {
  //       isLoading = false;
  //       GenericDialog().showSimplePopup(
  //         type: InfoBoxType.warning,
  //         title: ConstantString.apiErrorResponseTitle,
  //         content: res.message,
  //       );
  //     }
  //   } catch (e, stacktrace) {
  //     isLoading = false;
  //     debugPrint(e.toString());

  //     log(e.toString());
  //     log(stacktrace.toString());
  //   }
  // }

  // Future<void> resendOTP() async {
  //   try {
  //     isLoading = true;
  //     final res = await userRepository.resendOTP(phoneNumber, email);
  //     if (res.succeeded) {
  //       isLoading = false;
  //       debugPrint(res.data);
  //       GenericDialog().showSimplePopup(
  //         type: InfoBoxType.success,
  //         content: res.message,
  //       );
  //     } else {
  //       isLoading = false;
  //       GenericDialog().showSimplePopup(
  //         type: InfoBoxType.warning,
  //         content: res.message,
  //       );
  //     }
  //   } catch (e, stacktrace) {
  //     isLoading = false;
  //     debugPrint(e.toString());
  //     log(e.toString());
  //     log(stacktrace.toString());
  //   }
  // }
}
