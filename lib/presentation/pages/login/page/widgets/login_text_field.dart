import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';
import 'package:flu_warehouse_mobile/style/app_typography.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget with ExtensionMixin {
  const LoginTextField({
    super.key,
    required bool isPassword,
    required bool isEnabled,
    required String hintText,
    required TextEditingController controller,
  })  : _isPassword = isPassword,
        _isEnabled = isEnabled,
        _hintText = hintText,
        _controller = controller;

  final bool _isPassword;
  final bool _isEnabled;
  final String _hintText;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) => TextField(
        controller: _controller,
        enabled: _isEnabled,
        obscureText: _isPassword,
        style: AppTypography.body1.copyWith(
          color: context.getColors().primaryOrange,
        ),
        decoration: _textFieldDecoration(context),
      );

  InputDecoration _textFieldDecoration(BuildContext context) => InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: AppDimensions.xxm,
          horizontal: AppDimensions.m,
        ),
        focusedBorder: _borderInformation(context),
        disabledBorder: _borderInformation(context),
        enabledBorder: _borderInformation(context),
        border: _borderInformation(context),
        hintStyle: AppTypography.body1.copyWith(
          color: context.getColors().primaryOrange,
        ),
        hintText: _hintText,
        helperText: '',
      );

  OutlineInputBorder _borderInformation(BuildContext context) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppDimensions.xm)),
        borderSide: BorderSide(
          width: AppDimensions.xxxs,
          color: context.getColors().primaryOrange,
        ),
      );
}
