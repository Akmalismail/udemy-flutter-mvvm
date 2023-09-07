import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/language_manager.dart';

enum PreferencesKey {
  prefsKeyLang,
  prefsKeyOnBoardingScreen,
  prefsKeyIsUserLoggedIn,
}

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language =
        _sharedPreferences.getString(PreferencesKey.prefsKeyLang.name);

    return language ?? LanguageType.english.languageCode;
  }

  Future<void> setOnBoardingScreenViewied() async {
    _sharedPreferences.setBool(
      PreferencesKey.prefsKeyOnBoardingScreen.name,
      true,
    );
  }

  Future<bool> isOnBoardingsScreenViewed() async {
    return _sharedPreferences.getBool(
          PreferencesKey.prefsKeyOnBoardingScreen.name,
        ) ??
        false;
  }

  Future<void> setIsUserLoggedIn() async {
    _sharedPreferences.setBool(
      PreferencesKey.prefsKeyIsUserLoggedIn.name,
      true,
    );
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(
          PreferencesKey.prefsKeyIsUserLoggedIn.name,
        ) ??
        false;
  }
}
