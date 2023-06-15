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
  final Function? retryActionFunction;

  StateRenderer({
    super.key,
    required this.stateRendererType,
    Failure? failure,
    String? message,
    String? title,
    this.retryActionFunction,
  })  : message = message ?? AppStrings.loading,
        title = title ?? "",
        failure = failure ?? DefaultFailure();

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
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
          _getRetryButton(
            AppStrings.retryAgain,
            context,
          )
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          style: getMediumStyle(
            color: ColorManager.black,
            fontSize: FontSize.s16,
          ),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p18),
      child: SizedBox(
        width: AppSize.s180,
        child: ElevatedButton(
          onPressed: () {
            if (stateRendererType == StateRendererType.fullscreenErrorState) {
              retryActionFunction?.call();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(buttonTitle),
        ),
      ),
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
