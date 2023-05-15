import 'package:flutter/material.dart';
import 'package:udemy_flutter_mvvm/presentation/color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1, // for cases like disabled button
      colorScheme: ColorScheme.fromSeed(
          seedColor: ColorManager.primary, secondary: ColorManager.grey)

      // card view theme

      // app bar theme

      // button theme

      // text theme

      // input decoration theme (text form)
      );
}
