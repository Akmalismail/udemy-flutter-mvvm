import 'package:flutter/material.dart';
import 'package:udemy_flutter_mvvm/presentation/main/home_page.dart';
import 'package:udemy_flutter_mvvm/presentation/main/notifications_page.dart';
import 'package:udemy_flutter_mvvm/presentation/main/search_page.dart';
import 'package:udemy_flutter_mvvm/presentation/main/settings_page.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/strings_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationsPage(),
    const SettingsPage(),
  ];
  final _title = AppStrings.home;
  final _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: pages[_currentIndex],
    );
  }
}
