import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:udemy_flutter_mvvm/domain/model/model.dart';
import 'package:udemy_flutter_mvvm/domain/use_case/home_use_case.dart';
import 'package:udemy_flutter_mvvm/presentation/base/base_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  HomeUseCase _homeUseCase;

  final StreamController _serviceStreamController =
      BehaviorSubject<List<Service>>();
  final StreamController _storeStreamController =
      BehaviorSubject<List<Store>>();
  final StreamController _bannerStreamController =
      BehaviorSubject<List<Banner>>();

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    _getHome();
  }

  _getHome() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.fullscreenLoadingState),
    );

    (await _homeUseCase.execute(null)).fold(
      (failure) {
        inputState.add(
          ErrorState(StateRendererType.fullscreenErrorState, failure.message),
        );
      },
      (home) {
        inputState.add(ContentState());
        inputBanners.add(home.data.banners);
        inputStores.add(home.data.stores);
        inputServices.add(home.data.services);
      },
    );
  }

  @override
  void dispose() {
    _serviceStreamController.close();
    _storeStreamController.close();
    _bannerStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputBanners => _bannerStreamController.sink;

  @override
  Sink get inputServices => _serviceStreamController.sink;

  @override
  Sink get inputStores => _storeStreamController.sink;

  @override
  Stream<List<Banner>> get outputBanners =>
      _bannerStreamController.stream.map((banner) => banner);

  @override
  Stream<List<Service>> get outputServices =>
      _serviceStreamController.stream.map((service) => service);

  @override
  Stream<List<Store>> get outputStores =>
      _storeStreamController.stream.map((store) => store);
}

abstract class HomeViewModelInputs {
  Sink get inputStores;
  Sink get inputServices;
  Sink get inputBanners;
}

abstract class HomeViewModelOutputs {
  Stream<List<Store>> get outputStores;
  Stream<List<Service>> get outputServices;
  Stream<List<Banner>> get outputBanners;
}
