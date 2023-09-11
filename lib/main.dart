import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:udemy_flutter_mvvm/app/di.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/language_manager.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
    supportedLocales: const [englishLocale, arabicLocale],
    path: assetsPathLocalisations,
    child: Phoenix(
      child: MyApp(),
    ),
  ));
}
