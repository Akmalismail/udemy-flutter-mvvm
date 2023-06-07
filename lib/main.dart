import 'package:flutter/material.dart';
import 'package:udemy_flutter_mvvm/app/di.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
