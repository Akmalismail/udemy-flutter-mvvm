import 'package:flutter/material.dart';
import 'package:udemy_flutter_mvvm/app/di.dart';
import 'package:udemy_flutter_mvvm/presentation/main/home/home_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/strings_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel _viewModel = instance<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text(AppStrings.home));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
