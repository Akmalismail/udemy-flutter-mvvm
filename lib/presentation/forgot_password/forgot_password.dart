import 'package:flutter/material.dart';
import 'package:udemy_flutter_mvvm/app/di.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:udemy_flutter_mvvm/presentation/forgot_password/forgot_password_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/assets_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/strings_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/values_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordViewModel _viewModel =
      instance<ForgotPasswordViewModel>();

  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _emailController.addListener(
      () => _viewModel.setEmail(_emailController.text),
    );
  }

  @override
  void initState() {
    super.initState();
    _bind();
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
                  _viewModel.resetPassword();
                },
              ) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Center(
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
                  stream: _viewModel.outputIsEmailValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: AppStrings.email,
                        labelText: AppStrings.email,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.emailError,
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
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _viewModel.resetPassword();
                                }
                              : null,
                          child: const Text(AppStrings.resetPassword),
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
                child: StreamBuilder<bool>(
                    stream: _viewModel
                        .isPasswordResetSucessfullyStreamController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.data == true) {
                        return TextButton(
                          onPressed: () {
                            _viewModel.resetPassword();
                          },
                          child: Text(
                            AppStrings.didntReceiveEmail,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              )
            ],
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
