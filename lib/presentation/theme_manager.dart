import 'package:flutter/material.dart';
import 'package:udemy_flutter_mvvm/presentation/color_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/font_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/styles_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1, // for cases like disabled button
    splashColor: ColorManager.primaryOpacity70, // ripple color
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorManager.primary,
      secondary: ColorManager.grey,
    ),

    // card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManager.primaryOpacity70,
        titleTextStyle: getRegularStyle(
          color: ColorManager.white,
          fontSize: FontSize.s16,
        )),

    // button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.white),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),

    // text theme

    // input decoration theme (text form)
  );
}
