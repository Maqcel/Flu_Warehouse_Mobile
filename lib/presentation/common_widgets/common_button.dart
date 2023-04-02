import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';
import 'package:flu_warehouse_mobile/style/app_radius.dart';
import 'package:flu_warehouse_mobile/style/app_typography.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget with ExtensionMixin {
  const CommonButton({
    super.key,
    required String buttonText,
    required bool isEnabled,
    bool isMainAction = true,
    required void Function() onPressed,
  })  : _buttonText = buttonText,
        _isEnabled = isEnabled,
        _isMainAction = isMainAction,
        _onPressed = onPressed;
  final String _buttonText;
  final bool _isEnabled;
  final bool _isMainAction;
  final void Function() _onPressed;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Material(
              borderRadius: _buttonRadius(),
              child: InkWell(
                borderRadius: _buttonRadius(),
                onTap: _isEnabled ? _onPressed : null,
                child: _content(context),
              ),
            ),
          ),
        ],
      );

  BorderRadius _buttonRadius() => BorderRadius.circular(AppRadius.m);

  Widget _content(BuildContext context) => Ink(
        decoration: BoxDecoration(
          borderRadius: _buttonRadius(),
          color: _isEnabled
              ? _isMainAction
                  ? context.getColors().primaryYellow100
                  : context.getColors().primaryOrange
              : context.getColors().primaryGrey,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppDimensions.xm),
          child: Text(
            _buttonText,
            textAlign: TextAlign.center,
            style: AppTypography.header2.copyWith(
              color: _isMainAction
                  ? context.getColors().primaryBlack100
                  : context.getColors().secondaryBlack100,
            ),
          ),
        ),
      );
}
