import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/language_manager.dart';

enum PreferencesKey {
  language("PREFS_KEY_LANG");

  final String _key;
  const PreferencesKey(this._key);

  String get key => _key;
}

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language =
        _sharedPreferences.getString(PreferencesKey.language.key);

    return language ?? LanguageType.english.languageCode;
  }
}
