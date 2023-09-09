import 'dart:async';

import 'package:logger/logger.dart';
import 'package:udemy_flutter_mvvm/domain/use_case/forgot_password_use_case.dart';
import 'package:udemy_flutter_mvvm/presentation/base/base_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/common/freezed_data_classes.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController<bool> isPasswordResetSucessfullyStreamController =
      StreamController<bool>();

  var resetPasswordFields = const ResetPasswordFields(
    email: "",
  );

  final ForgotPasswordUseCase _forgotPasswordUseCase;
  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  // inputs
  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // view tells state renderer, please show the content of the screen.
    inputState.add(ContentState());
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  resetPassword() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.popupLoadingState),
    );

    Logger logger = Logger();
    final response = await _forgotPasswordUseCase.execute(
      ForgotPasswordUseCaseInput(
        resetPasswordFields.email,
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
        inputState.add(SuccessState(data));
        isPasswordResetSucessfullyStreamController.add(true);
      },
    );
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    resetPasswordFields = resetPasswordFields.copyWith(email: email);
    _validate();
  }

  // outputs

  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map(
        (email) => _isEmailValid(email),
      );

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  // private functions
  void _validate() {
    inputIsAllInputsValid.add(null);
  }

  bool _isEmailValid(String username) {
    return username.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isEmailValid(resetPasswordFields.email);
  }
}

abstract class ForgotPasswordViewModelInputs {
  // 3 functions
  setEmail(String email);
  resetPassword();

  // 2 sinks
  Sink get inputEmail;
  Sink get inputIsAllInputsValid;
}

abstract class ForgotPasswordViewModelOutputs {
  // 2 streams
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputsValid;
}
