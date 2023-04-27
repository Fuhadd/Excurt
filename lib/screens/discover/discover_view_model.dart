import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/view_model/base_change_notifier.dart';
import '../../models/user_data.dart';

final discoverProvider = ChangeNotifierProvider<DiscoverViewModel>((ref) {
  return DiscoverViewModel.exploreSetup();
});

class DiscoverViewModel extends BaseChangeNotifier {
  bool _isloading;

  String authorized = 'Not Authorized';

  DiscoverViewModel.exploreSetup() : _isloading = false;

  bool get isLoading => _isloading;

  set isLoading(bool isloading) {
    _isloading = isloading;
    notifyListeners();
  }

  Future<void> getUsersForMatching({
    required int pageNumber,
    required int pageSize,
    required WidgetRef ref,
    BuildContext? context,
  }) async {
    try {
      isLoading = true;
      final res = await userRepository.getUsersForMatching(
        pageNumber,
        pageSize,
      );

      if (res.success) {
        for (var users in res.data) {
          var userData = UserDataModel.fromJson(users);
          ref.read(discoverMatchesProvider.notifier).state = [
            ...ref.watch(discoverMatchesProvider),
            userData
          ];

          // ref.read(discoverMatchesProvider.notifier).state.add(userData);
        }
      } else {
        isLoading = false;
        ScaffoldMessenger.of(context!)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(res.errors!.join('\n')),
            backgroundColor: Colors.red,
          ));
      }
    } catch (e, stacktrace) {
      isLoading = false;
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }
}

final discoverMatchesProvider = StateProvider<List<UserDataModel>>((ref) => []);

// final allUsersForMatchingProvider =
//     FutureProvider.family<List<UserDataModel>?, RefContextModel>(
//         (ref, widgetRef) async {
//   await DiscoverViewModel.exploreSetup().getUsersForMatching(
//       pageNumber: 1,
//       pageSize: 3,
//       ref: widgetRef.ref,
//       context: widgetRef.context);

//   return widgetRef.ref.watch(discoverMatchesProvider);
// });
