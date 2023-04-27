// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, unused_field

import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/view_model/base_change_notifier.dart';

final preLaunchProvider =
    ChangeNotifierProvider.autoDispose<PrelaunchViewModel>((ref) {
  return PrelaunchViewModel.initWhoAmI();
});

enum OnboardingType { newCustomer, existingCustomer }

enum VersionStatus { canLogin, maintenance, forceUpdateVersion }

extension VersionStatusDetails on VersionStatus {
  int get description {
    switch (this) {
      case VersionStatus.canLogin:
        return 1;
      case VersionStatus.maintenance:
        return 2;
      case VersionStatus.forceUpdateVersion:
        return 3;
    }
  }
}

class PrelaunchViewModel extends BaseChangeNotifier {
  bool _isloading;
  // final LocalAuthentication auth = LocalAuthentication();
  String authorized = 'Not Authorized';
  PrelaunchViewModel.initWhoAmI() : _isloading = false {
    // preLaunch();
    getContactInfo();
  }

  set isLoading(bool isloading) {
    _isloading = isloading;
    notifyListeners();
  }

  var _androidInfo, _iosInfo;
  // AndroidDeviceInfo? get androidInfo => _androidInfo;
  // IosDeviceInfo? get iosInfo => _iosInfo;

  // getDeviceInfo() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isAndroid) {
  //     _androidInfo = await deviceInfo.androidInfo;
  //   } else {
  //     _iosInfo = await deviceInfo.iosInfo;
  //   }
  //   notifyListeners();
  // }

  // Map<String, dynamic> decodeUserData(String code) {
  //   String normalizedSource = base64Url.normalize(code.split(".")[1]);
  //   return json.decode(utf8.decode(base64Url.decode(normalizedSource)));
  // }

  // int getExtendedVersionNumber(String version) {
  //   List versionCells = version.split('.');
  //   versionCells = versionCells.map((i) => int.parse(i)).toList();
  //   return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  // }

  // Future<void> preLaunch() async {
  //   try {
  //     isLoading = true;

  //     final res = await userRepository.prelaunch();
  //     if (res.succeeded) {
  //       final packageInfo = await getAppInfo();
  //       int currentVersionNumber =
  //           getExtendedVersionNumber(packageInfo!.version);
  //       isLoading = false;
  //       var data = PreLaunchModel.fromJson(res.data);
  //       locator<LocalCache>().saveToLocalCache(
  //           key: ConstantString.preLaunchData, value: jsonEncode(data));
  //       int incomingVersionNumber =
  //           getExtendedVersionNumber(data.appAccess.version);
  //       if (data.appAccess.status == VersionStatus.canLogin.description ||
  //           (data.appAccess.status ==
  //                   VersionStatus.forceUpdateVersion.description &&
  //               currentVersionNumber >= incomingVersionNumber)) {
  //         //TODO
  //         // second OR statement to keep the onboarding slider showing for now ... should remove it later
  //         if (localCache.getUserData().userid.isEmpty ||
  //             localCache.getUserData().userid.isNotEmpty) {
  //           Timer(const Duration(seconds: 3), () async {
  //             navigationHandler.pushNamed(OnboardingIntro.id);
  //           });
  //         } else {
  //           Timer(const Duration(seconds: 4), () async {
  //             navigationHandler.pushNamed(SignIn.id);
  //           });
  //         }
  //         //}
  //         //else {
  //         if (data.appAccess.status ==
  //             VersionStatus.forceUpdateVersion.description) {
  //           navigationHandler.pushNamed(PrelaunchScreen.id, arg: {
  //             'data': data,
  //             'versionStatus': VersionStatus.forceUpdateVersion
  //           });
  //         } else if (data.appAccess.status ==
  //             VersionStatus.maintenance.description) {
  //           navigationHandler.pushNamed(PrelaunchScreen.id, arg: {
  //             'data': data,
  //             'versionStatus': VersionStatus.maintenance
  //           });
  //         }
  //       }
  //     }
  //   } catch (e, stacktrace) {
  //     isLoading = false;
  //     log(e.toString());
  //     log(stacktrace.toString());
  //   }
  // }

  Future<void> getContactInfo() async {
    try {
      //isLoading = true;

      final res = await userRepository.getContactInfo();
      if (res.success) {
        log(res.data);
        print("This is the res data ${res.data}");
      } else {
        //isLoading = false;
        print("This is the res error ${res.message}");
      }
    } catch (e, stacktrace) {
      print("This is the res error ${e.toString()}");
      log(e.toString());
      log(stacktrace.toString());
    }
  }
}
