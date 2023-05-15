import 'package:flutter/material.dart';
import 'package:udemy_flutter_mvvm/app/app.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  void updateAppState() {
    MyApp.instance.appState = 10;
  }

  void getAppState() {
    // ignore: avoid_print
    print(MyApp.instance.appState);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
