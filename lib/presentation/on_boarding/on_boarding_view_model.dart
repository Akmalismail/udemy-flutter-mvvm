import 'dart:async';

import 'package:udemy_flutter_mvvm/domain/model.dart';
import 'package:udemy_flutter_mvvm/presentation/base/base_view_model.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // stream controllers
  final StreamController _streamController =
      StreamController<SlideViewObject>();

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

  Sink get inputSliderViewObject; // a way to add data to stream. stream input
}

// outputs - data / results sent to view
abstract class OnBoardingViewModelOutputs {
  Stream<SlideViewObject>
      get outputSliderViewObject; // a way to add data to stream. stream input
}

class SlideViewObject {
  SliderObject sliderObject;
  int numberOfSlides;
  int currentIndex;

  SlideViewObject(this.sliderObject, this.numberOfSlides, this.currentIndex);
}
