import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter_mvvm/app/app_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  // shared preferences instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // app preferences instance
  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(instance()),
  );
}
