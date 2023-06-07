import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:udemy_flutter_mvvm/domain/use_case/login_use_case.dart';
import 'package:udemy_flutter_mvvm/presentation/login/login_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/assets_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/color_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // TODO: loginUseCase
  final LoginViewModel _viewModel = LoginViewModel({} as LoginUseCase);
  final TextEditingController _usernameController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    // _viewModel.start();
    // _usernameController.addListener(
    //   () => _viewModel.setUsername(_usernameController.text),
    // );
    // _passwordController.addListener(
    //   () => _viewModel.setPassword(_passwordController.text),
    // );
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SvgPicture.asset(ImageAssets.loginIcon),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsUsernameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _usernameController,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _viewModel.dispose();
    super.dispose();
  }
}
