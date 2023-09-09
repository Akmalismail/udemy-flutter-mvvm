import 'package:flutter/material.dart';
import 'package:udemy_flutter_mvvm/app/di.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:udemy_flutter_mvvm/presentation/register/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _bind() {
    _viewModel.start();
    _userNameController.addListener(() {
      _viewModel.setUserName(_userNameController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });
    _mobileNumberController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberController.text);
    });
    _emailController.addListener(() {
      _viewModel.setEmail(_emailController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context,
                _getContentWidget(),
                () {
                  _viewModel.register();
                },
              ) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
