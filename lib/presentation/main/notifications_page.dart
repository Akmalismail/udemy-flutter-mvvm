import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/strings_manager.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: const Text(AppStrings.notifications).tr());
  }
}
