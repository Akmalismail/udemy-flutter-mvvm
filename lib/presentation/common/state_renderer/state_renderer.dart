import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/assets_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/color_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/font_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/strings_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/styles_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/values_manager.dart';

enum StateRendererType {
  // popup states
  popupLoadingState,
  popupErrorState,
  popupSuccessState,

  // full screen states
  fullscreenLoadingState,
  fullscreenErrorState,

  contentScreenState, // ui of screen
  emptyScreenState, // empty view when no data from api for list screen
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function? retryActionFunction;

  const StateRenderer({
    super.key,
    required this.stateRendererType,
    String? message,
    String? title,
    this.retryActionFunction,
  })  : message = message ?? AppStrings.loading,
        title = title ?? "";

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopupDialog(context, [
          _getAnimatedImage(JsonAssets.loading),
        ]);
      case StateRendererType.popupErrorState:
        return _getPopupDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context),
        ]);
      case StateRendererType.popupSuccessState:
        return _getPopupDialog(context, [
          _getAnimatedImage(JsonAssets.success),
          _getMessage(AppStrings.success),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context),
        ]);
      case StateRendererType.fullscreenLoadingState:
        return _getItemsInColumn([
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(message),
        ]);
      case StateRendererType.fullscreenErrorState:
        return _getItemsInColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(
            AppStrings.retryAgain,
            context,
          )
        ]);
      case StateRendererType.contentScreenState:
        return Container();
      case StateRendererType.emptyScreenState:
        return _getItemsInColumn([
          _getAnimatedImage(JsonAssets.empty),
          _getMessage(message),
        ]);
      default:
        return Container();
    }
  }

  Widget _getPopupDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: AppSize.s12,
              offset: Offset(AppSize.s0, AppSize.s12),
            ),
          ],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
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
