import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter_mvvm/app/app_preferences.dart';
import 'package:udemy_flutter_mvvm/data/data_source/local_data_source.dart';
import 'package:udemy_flutter_mvvm/data/data_source/remote_data_source.dart';
import 'package:udemy_flutter_mvvm/data/network/app_api.dart';
import 'package:udemy_flutter_mvvm/data/network/dio_factory.dart';
import 'package:udemy_flutter_mvvm/data/network/network_info.dart';
import 'package:udemy_flutter_mvvm/data/repository/repository_impl.dart';
import 'package:udemy_flutter_mvvm/domain/respository/repository.dart';
import 'package:udemy_flutter_mvvm/domain/use_case/forgot_password_use_case.dart';
import 'package:udemy_flutter_mvvm/domain/use_case/home_use_case.dart';
import 'package:udemy_flutter_mvvm/domain/use_case/login_use_case.dart';
import 'package:udemy_flutter_mvvm/domain/use_case/register_use_case.dart';
import 'package:udemy_flutter_mvvm/presentation/forgot_password/forgot_password_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/login/login_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/main/home/home_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/register/register_view_model.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  // shared preferences instance
  instance.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );

  // app preferences instance
  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(instance()),
  );

  // network info
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(Connectivity()),
  );

  // dio factory
  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(instance()),
  );

  // app service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(
    () => AppServiceClient(dio),
  );

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImplementer(instance()),
  );

  // local data source
  instance.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImplementer(),
  );

  // repository
  instance.registerLazySingleton<Repository>(
    () => RepositoryImplementer(instance(), instance(), instance()),
  );
}

initLoginModule() async {
  if (instance.isRegistered<LoginUseCase>()) {
    return;
  }

  instance.registerFactory<LoginUseCase>(
    () => LoginUseCase(instance()),
  );
  instance.registerFactory<LoginViewModel>(
    () => LoginViewModel(instance()),
  );
}

initForgotPasswordModule() async {
  if (instance.isRegistered<ForgotPasswordUseCase>()) {
    return;
  }

  instance.registerFactory<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(instance()),
  );
  instance.registerFactory<ForgotPasswordViewModel>(
    () => ForgotPasswordViewModel(instance()),
  );
}

initRegisterModule() async {
  if (instance.isRegistered<RegisterUseCase>()) {
    return;
  }

  instance.registerFactory<RegisterUseCase>(
    () => RegisterUseCase(instance()),
  );
  instance.registerFactory<RegisterViewModel>(
    () => RegisterViewModel(instance()),
  );
  instance.registerFactory<ImagePicker>(
    () => ImagePicker(),
  );
}

initHomeModule() async {
  if (instance.isRegistered<HomeUseCase>()) {
    return;
  }

  instance.registerFactory<HomeUseCase>(
    () => HomeUseCase(instance()),
  );
  instance.registerFactory<HomeViewModel>(
    () => HomeViewModel(instance()),
  );
}
