import 'package:shared_preferences/shared_preferences.dart';
import 'package:stepOut/app/core/utils/app_storage_keys.dart';

class SplashRepo {
  final SharedPreferences sharedPreferences;
  SplashRepo({required this.sharedPreferences});

  bool get isLogin => sharedPreferences.containsKey(AppStorageKey.isLogin);

  bool get isFirstTime =>
      !sharedPreferences.containsKey(AppStorageKey.notFirstTime);

  setFirstTime() {
    sharedPreferences.setBool(AppStorageKey.notFirstTime, true);
  }
}
