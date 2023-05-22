enum LanguageType {
  english("en"),
  arabic("ar");

  final String languageCode;

  const LanguageType(this.languageCode);

  String getCode() => languageCode;
}
