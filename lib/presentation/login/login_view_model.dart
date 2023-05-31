import 'dart:async';

import 'package:udemy_flutter_mvvm/presentation/base/base_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  var loginCredentials = LoginCredentials(
    username: "",
    password: "",
  );

  // inputs
  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
    throw UnimplementedError();
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  // TODO: implement inputUsername
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginCredentials = loginCredentials.copyWith(password: password);
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    loginCredentials = loginCredentials.copyWith(username: username);
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

  // private functions
  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUsenameValid(String username) {
    return username.isNotEmpty;
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
}

abstract class LoginViewModelOutputs {
  // 2 streams
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
}
