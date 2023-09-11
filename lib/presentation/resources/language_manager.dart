import 'package:flutter/material.dart';

const String assetsPathLocalisations = 'assets/translations';
const Locale arabicLocale = Locale('ar', 'SA');
const Locale englishLocale = Locale('en', 'US');

enum LanguageType {
  english("en"),
  arabic("ar");

  final String languageCode;

  const LanguageType(this.languageCode);

  String getCode() => languageCode;
}
