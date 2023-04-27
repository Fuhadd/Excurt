import 'package:flutter/foundation.dart';
import '../../locator.dart';
import '../../utils/navigator_handler.dart';
import '../api_config/app_logger.dart';
import '../api_config/local_cache.dart';
import '../repositories/user_repo.dart';

class BaseChangeNotifier extends ChangeNotifier {
  late UserRepository userRepository;
  late LocalCache localCache;
  late NavigationHandler navigationHandler;

  BaseChangeNotifier({
    UserRepository? userRepository,
    LocalCache? localCache,
    NavigationHandler? navigationHandler,
  }) {
    this.userRepository = userRepository ?? locator();
    this.localCache = localCache ?? locator();
    this.navigationHandler = navigationHandler ?? locator();
  }

  // ignore: prefer_final_fields
  bool _loading = false;

  bool get loading => _loading;
  void log(Object? e) {
    AppLogger.log("$e");
  }
}
