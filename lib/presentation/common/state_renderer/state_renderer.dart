import 'package:flutter/material.dart';
import 'package:udemy_flutter_mvvm/data/network/failure.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/strings_manager.dart';

enum StateRendererType {
  // popup states
  popupLoadingState,
  popupErrorState,

  // full screen states
  fullscreenLoadingState,
  fullscreenErrorState,

  contentScreenState, // ui of screen
  emptyScreenState, // empty view when no data from api for list screen
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final Failure failure;
  final String message;
  final String title;
  final Function retryActionFunction;

  StateRenderer({
    super.key,
    required this.stateRendererType,
    Failure? failure,
    String? message,
    String? title,
    required this.retryActionFunction,
  })  : message = message ?? AppStrings.loading,
        title = title ?? "",
        failure = failure ?? DefaultFailure();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
