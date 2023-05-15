abstract class BaseViewModel {
  // shared class members that will be used throughout any view model.
}

abstract class BaseViewModelInputs {
  void start(); // will be called while init. of view model
  void dispose(); // will be called when ViewModel destroyed
}

abstract class BaseViewModelOutputs {}
