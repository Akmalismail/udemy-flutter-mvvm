import 'dart:async';

import 'package:udemy_flutter_mvvm/domain/model.dart';
import 'package:udemy_flutter_mvvm/presentation/base/base_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/assets_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // stream controllers
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void start() {
    _list = _getSliderData();
    // send this slider data to view
    _postDataToView();
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  int goNext() {
    _currentIndex++;
    if (_currentIndex >= _list.length) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    _currentIndex--;
    if (_currentIndex == -1) {
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map(
        (slideViewObject) => slideViewObject,
      );

  // private functions
  List<SliderObject> _getSliderData() => [
        SliderObject(
          AppStrings.onBoardingTitle1,
          AppStrings.onBoardingSubtitle1,
          ImageAssets.onBoardingLogo1,
        ),
        SliderObject(
          AppStrings.onBoardingTitle2,
          AppStrings.onBoardingSubtitle2,
          ImageAssets.onBoardingLogo2,
        ),
        SliderObject(
          AppStrings.onBoardingTitle3,
          AppStrings.onBoardingSubtitle3,
          ImageAssets.onBoardingLogo3,
        ),
        SliderObject(
          AppStrings.onBoardingTitle4,
          AppStrings.onBoardingSubtitle4,
          ImageAssets.onBoardingLogo4,
        ),
      ];

  void _postDataToView() {
    inputSliderViewObject.add(
      SliderViewObject(
          _list, _list[_currentIndex], _list.length, _currentIndex),
    );
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
  Stream<SliderViewObject>
      get outputSliderViewObject; // a way to add data to stream. stream input
}

class SliderViewObject {
  List<SliderObject> list;
  SliderObject currentSliderObject;
  int numberOfSlides;
  int currentIndex;

  SliderViewObject(this.list, this.currentSliderObject, this.numberOfSlides,
      this.currentIndex);
}
