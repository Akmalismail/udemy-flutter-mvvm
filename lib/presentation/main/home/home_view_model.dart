import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:udemy_flutter_mvvm/domain/model/model.dart';
import 'package:udemy_flutter_mvvm/domain/use_case/home_use_case.dart';
import 'package:udemy_flutter_mvvm/presentation/base/base_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final HomeUseCase _homeUseCase;

  final _dataStreamController = BehaviorSubject<HomeViewObject>();

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
        inputHomeData.add(HomeViewObject(
          home.data.stores,
          home.data.services,
          home.data.banners,
        ));
      },
    );
  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  @override
  Stream<HomeViewObject> get outputHomeData =>
      _dataStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<BannerAd> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}
