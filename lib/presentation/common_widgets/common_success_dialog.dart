import 'package:flu_warehouse_mobile/generated/assets/assets.gen.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_button.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';
import 'package:flu_warehouse_mobile/style/app_typography.dart';
import 'package:flutter/material.dart';

class CommonSuccessDialog extends StatelessWidget {
  const CommonSuccessDialog({
    super.key,
    required String bodyText,
    required String buttonText,
    required VoidCallback onButtonPressed,
  })  : _bodyText = bodyText,
        _buttonText = buttonText,
        _onButtonPressed = onButtonPressed;

  final String _bodyText;
  final String _buttonText;
  final VoidCallback _onButtonPressed;

  @override
  Widget build(BuildContext context) => Dialog(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.ms),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Assets.icons.checkmark.svg(
                color: Colors.green,
                height: AppDimensions.xxxc,
              ),
              SizedBox(height: AppDimensions.m),
              Text(
                _bodyText,
                style: AppTypography.body1,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.m),
              CommonButton(
                buttonText: _buttonText,
                isEnabled: true,
                onPressed: _onButtonPressed,
              ),
            ],
          ),
        ),
      );
}
