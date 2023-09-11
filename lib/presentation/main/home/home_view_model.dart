import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:udemy_flutter_mvvm/domain/model/model.dart';
import 'package:udemy_flutter_mvvm/domain/use_case/home_use_case.dart';
import 'package:udemy_flutter_mvvm/presentation/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  HomeUseCase _homeUseCase;

  final StreamController _serviceStreamController =
      BehaviorSubject<List<Service>>();
  final StreamController _storeStreamController =
      BehaviorSubject<List<Store>>();
  final StreamController _bannerStreamController =
      BehaviorSubject<List<Banner>>();

  HomeViewModel(this._homeUseCase);

  @override
  void start() {}

  @override
  void dispose() {
    _serviceStreamController.close();
    _storeStreamController.close();
    _bannerStreamController.close();
    super.dispose();
  }
}

abstract class HomeViewModelInput {}

abstract class HomeViewModelOutput {}
