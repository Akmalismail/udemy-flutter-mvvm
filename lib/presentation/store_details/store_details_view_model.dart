import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:udemy_flutter_mvvm/domain/model/model.dart';
import 'package:udemy_flutter_mvvm/domain/use_case/store_details_use_case.dart';
import 'package:udemy_flutter_mvvm/presentation/base/base_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';

class StoreDetailsViewModal extends BaseViewModel
    with StoreDetailsViewModelInputs, StoreDetailsViewModelOutputs {
  final StoreDetailsUseCase _storeDetailsUseCase;

  final _storeDetailsStreamContoller = BehaviorSubject<StoreDetails>();

  StoreDetailsViewModal(this._storeDetailsUseCase);

  @override
  void start() {
    _loadData();
  }

  _loadData() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.fullscreenLoadingState),
    );

    (await _storeDetailsUseCase.execute(null)).fold(
      (failure) {
        inputState.add(
          ErrorState(StateRendererType.fullscreenErrorState, failure.message),
        );
      },
      (storeDetails) {
        inputState.add(ContentState());
        inputStoreDetails.add(storeDetails);
      },
    );
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamContoller.sink;

  @override
  void dispose() {
    _storeDetailsStreamContoller.close();
    super.dispose();
  }

  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamContoller.stream.map((storeDetails) => storeDetails);
}

abstract class StoreDetailsViewModelInputs {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutputs {
  Stream<StoreDetails> get outputStoreDetails;
}
