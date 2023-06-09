import 'package:flutter/material.dart';
import 'package:udemy_flutter_mvvm/app/di.dart';
import 'package:udemy_flutter_mvvm/presentation/login/login_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/assets_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/color_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/routes_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/strings_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _usernameController.addListener(
      () => _viewModel.setUsername(_usernameController.text),
    );
    _passwordController.addListener(
      () => _viewModel.setPassword(_passwordController.text),
    );
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
      backgroundColor: ColorManager.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: AppPadding.p12,
            bottom: AppPadding.p12,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(ImageAssets.splashLogo),
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
                        decoration: InputDecoration(
                          hintText: AppStrings.username,
                          labelText: AppStrings.username,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.usernameError,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: AppStrings.password,
                          labelText: AppStrings.password,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.passwordError,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    _viewModel.login();
                                  }
                                : null,
                            child: const Text(AppStrings.login),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.forgotPasswordRoute,
                            );
                          },
                          child: Text(
                            AppStrings.forgetPassword,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Align(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.registerRoute,
                              );
                            },
                            child: Text(
                              AppStrings.registerText,
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ),
                    ],
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
    _viewModel.dispose();
    super.dispose();
  }
}
