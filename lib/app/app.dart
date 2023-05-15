import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  ///
  /// Default constructor not used.
  /// When MyApp instance is first created, it will use `factory MyApp()` constructor instead.
  ///
  // const MyApp({super.key});

  MyApp._internal(); // private named instructor

  static MyApp instance = MyApp._internal(); // single instance -- singleton

  factory MyApp() => instance; // factory for the class instance

  int appState = 0;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
