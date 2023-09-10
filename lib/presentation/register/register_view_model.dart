import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:udemy_flutter_mvvm/app/functions.dart';
import 'package:udemy_flutter_mvvm/domain/use_case/register_use_case.dart';
import 'package:udemy_flutter_mvvm/presentation/base/base_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/common/freezed_data_classes.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController<String> _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _mobileNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController<File> _profilePictureStreamController =
      StreamController<File>.broadcast();
  final StreamController<void> _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  final RegisterUseCase _registerUseCase;

  var registerFields = const RegisterFields(
    countryMobileCode: "",
    userName: "",
    password: "",
    mobileNumber: "",
    email: "",
    profilePicture: "",
  );

  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    // view tells state renderer, please show the content of the screen.
    inputState.add(ContentState());
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

  // --- inputs ---
  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  setUserName(String userName) {
    inputUserName.add(userName);

    if (_isUserNameValid(userName)) {
      // update register view object with username value
      registerFields = registerFields.copyWith(userName: userName);
    } else {
      // reset username value in register view object
      registerFields = registerFields.copyWith(userName: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);

    if (_isPasswordValid(password)) {
      registerFields = registerFields.copyWith(password: password);
    } else {
      registerFields = registerFields.copyWith(password: "");
    }
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);

    if (_isMobileNumberValid(mobileNumber)) {
      registerFields = registerFields.copyWith(mobileNumber: mobileNumber);
    } else {
      registerFields = registerFields.copyWith(mobileNumber: "");
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);

    if (isEmailValid(email)) {
      registerFields = registerFields.copyWith(email: email);
    } else {
      registerFields = registerFields.copyWith(email: "");
    }
    _validate();
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      registerFields = registerFields.copyWith(countryMobileCode: countryCode);
    } else {
      registerFields = registerFields.copyWith(countryMobileCode: "");
    }
    _validate();
  }

  @override
  setProfilePicutre(File file) {
    inputProfilePicture.add(file);

    if (file.path.isNotEmpty) {
      registerFields = registerFields.copyWith(profilePicture: file.path);
    } else {
      registerFields = registerFields.copyWith(profilePicture: "");
    }
    _validate();
  }

  // --- outputs ---
  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUserNameValid) => isUserNameValid ? null : "Invalid username");

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail =>
      outputIsEmailValid.map((email) => email ? null : "Invalid Email");

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      _mobileNumberStreamController.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber => outputIsMobileNumberValid
      .map((mobileNumber) => mobileNumber ? null : "Invalid Mobile Number");

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((password) => password ? null : "Invalid Password");

  @override
  Stream<File?> get outputProfilePictureValid =>
      _profilePictureStreamController.stream
          .map((profilePicture) => profilePicture);

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _validateAllInputs());

  @override
  register() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.popupLoadingState),
    );

    Logger logger = Logger();
    final response = await _registerUseCase.execute(
      RegisterUseCaseInput(
        registerFields.mobileNumber,
        registerFields.countryMobileCode,
        registerFields.userName,
        registerFields.email,
        registerFields.password,
        registerFields.profilePicture,
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
        inputState.add(SuccessState());
      },
    );
  }

  // --- private methods
  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _validateAllInputs() {
    return registerFields.countryMobileCode.isNotEmpty &&
        registerFields.userName.isNotEmpty &&
        registerFields.password.isNotEmpty &&
        registerFields.mobileNumber.isNotEmpty &&
        registerFields.email.isNotEmpty &&
        registerFields.profilePicture.isNotEmpty;
  }

  void _validate() {
    inputAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInput {
  register();
  setUserName(String userName);
  setMobileNumber(String mobileNumber);
  setCountryCode(String countryCode);
  setEmail(String email);
  setPassword(String password);
  setProfilePicutre(File file);

  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputAllInputsValid;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<File?> get outputProfilePictureValid;

  Stream<bool> get outputIsAllInputsValid;
}
