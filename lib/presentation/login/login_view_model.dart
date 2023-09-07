import 'dart:async';

import 'package:logger/logger.dart';
import 'package:udemy_flutter_mvvm/domain/use_case/login_use_case.dart';
import 'package:udemy_flutter_mvvm/presentation/base/base_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/common/freezed_data_classes.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  var loginFields = const LoginFields(
    username: "",
    password: "",
  );

  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  // inputs
  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // view tells state renderer, please show the content of the screen.
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  login() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.popupLoadingState),
    );

    Logger logger = Logger();
    final response = await _loginUseCase.execute(
      LoginUseCaseInput(
        loginFields.username,
        loginFields.password,
      ),
    );

    response.fold(
      (failure) {
        // left > failure
        inputState.add(
          ErrorState(StateRendererType.popupErrorState, failure.message),
        );
        logger.e('${failure.code}: ${failure.message}');
      },
      (data) {
        // right > success (data)
        logger.i(data.customer?.name);
        inputState.add(ContentState());

        // navigate to main screen after the login
        isUserLoggedInSuccessfullyStreamController.add(true);
      },
    );
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginFields = loginFields.copyWith(password: password);
    _validate();
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    loginFields = loginFields.copyWith(username: username);
    _validate();
  }

  // outputs
  @override
  Stream<bool> get outputIsPasswordValid =>
      _passwordStreamController.stream.map(
        (password) => _isPasswordValid(password),
      );

  @override
  Stream<bool> get outputIsUsernameValid =>
      _usernameStreamController.stream.map(
        (username) => _isUsenameValid(username),
      );

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  // private functions
  void _validate() {
    inputIsAllInputsValid.add(null);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUsenameValid(String username) {
    return username.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isUsenameValid(loginFields.username) &&
        _isPasswordValid(loginFields.password);
  }
}

abstract class LoginViewModelInputs {
  // 3 functions
  setUsername(String username);
  setPassword(String password);
  login();

  // 2 sinks
  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputIsAllInputsValid;
}

abstract class LoginViewModelOutputs {
  // 2 streams
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}
