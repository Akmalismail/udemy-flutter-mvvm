import 'package:udemy_flutter_mvvm/presentation/base/base_view_model.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void goNext() {
    // TODO: implement goNext
  }

  @override
  void goPrevious() {
    // TODO: implement goPrevious
  }

  @override
  void onPageChanged(int index) {
    // TODO: implement onPageChanged
  }
}

// inputs - orders received from view
abstract class OnBoardingViewModelInputs {
  void goNext(); // when user clicks on right arrow / swipe right
  void goPrevious(); // when user clicks on left arrow / swipe left
  void onPageChanged(int index);
}

// outputs - data / results sent to view
abstract class OnBoardingViewModelOutputs {}
