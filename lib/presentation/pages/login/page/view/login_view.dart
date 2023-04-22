import 'package:flu_warehouse_mobile/l10n/l10n.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_button.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/page/widgets/login_text_field.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
    required bool isLoginInProgress,
    required void Function(String, String) onLoginButtonPressed,
  })  : _isLoginInProgress = isLoginInProgress,
        _onLoginButtonPressed = onLoginButtonPressed;

  final bool _isLoginInProgress;
  final void Function(String, String) _onLoginButtonPressed;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _loginEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: EdgeInsets.all(AppDimensions.ms),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoginTextField(
                isEnabled: !widget._isLoginInProgress,
                isPassword: false,
                hintText: context.l10n.loginScreenLoginHintText,
                controller: _loginEditingController,
              ),
              SizedBox(height: AppDimensions.ms),
              LoginTextField(
                isEnabled: !widget._isLoginInProgress,
                isPassword: true,
                hintText: context.l10n.loginScreenPasswordHintText,
                controller: _passwordEditingController,
              ),
              SizedBox(height: AppDimensions.ms),
              CommonButton(
                buttonText: context.l10n.loginScreenButtonText,
                isEnabled: !widget._isLoginInProgress,
                onPressed: () => widget._onLoginButtonPressed(
                  _loginEditingController.text,
                  _passwordEditingController.text,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    _loginEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }
}
