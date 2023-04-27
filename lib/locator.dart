import 'package:escurt/utils/secure_storage.dart';
import 'package:escurt/utils/secure_storage_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/api_config/local_cache.dart';
import 'data/api_config/local_cache_impl.dart';
import 'data/repositories/user_repo.dart';
import 'utils/navigator_handler.dart';

GetIt locator = GetIt.instance;

///Registers dependencies
Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(sharedPreferences);

  //Local storage
  locator.registerLazySingleton<SecureStorage>(
    () => SecureStorageImpl(),
  );

  // //Local storage
  locator.registerLazySingleton<NavigationHandler>(
    () => NavigationHandlerImpl(),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      cache: locator(),
    ),
  );

  locator.registerLazySingleton<LocalCache>(
    () => LocalCacheImpl(
      sharedPreferences: locator(),
      storage: locator(),
    ),
  );
}
