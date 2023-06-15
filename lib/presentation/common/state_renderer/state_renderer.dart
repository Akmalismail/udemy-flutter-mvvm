import 'package:flutter/material.dart';
import 'package:udemy_flutter_mvvm/data/network/failure.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/color_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/font_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/strings_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/styles_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/values_manager.dart';

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

  Widget _getStateWidget() {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
      case StateRendererType.popupErrorState:
        return Container();
      case StateRendererType.fullscreenLoadingState:
        return _getItemsInColumn([
          _getAnimatedImage(),
          _getMessage(message),
        ]);
      case StateRendererType.fullscreenErrorState:
        return _getItemsInColumn([
          _getAnimatedImage(),
          _getMessage(failure.message),
          _getRetryButton(AppStrings.retryAgain)
        ]);
      case StateRendererType.contentScreenState:
      case StateRendererType.emptyScreenState:
      default:
        return Container();
    }
  }

  Widget _getAnimatedImage() {
    return const SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Placeholder(),
    );
  }

  Widget _getMessage(String message) {
    return Text(
      message,
      style: getMediumStyle(
        color: ColorManager.black,
        fontSize: FontSize.s16,
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(buttonTitle),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
