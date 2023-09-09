import 'dart:async';
import 'dart:io';

import 'package:udemy_flutter_mvvm/presentation/base/base_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';

class RegisterViewModel extends BaseViewModel {
  StreamController<String> _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController<String> _mobileNumberStreamController =
      StreamController<String>.broadcast();
  StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();
  StreamController<String> _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController<File> _profilePictureStreamController =
      StreamController<File>.broadcast();
  StreamController<void> _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    _isAllInputsValidStreamController.close();
    super.dispose();
  }
}

abstract class RegisterViewModelInput {
  register();

  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<String> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;
  Stream<String> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String> get outputErrorPassword;

  Stream<bool> get outputIsProfilePictureValid;
}
