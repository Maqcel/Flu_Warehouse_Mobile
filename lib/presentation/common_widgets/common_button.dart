import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
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
            child: ElevatedButton(
              onPressed: _isEnabled ? _onPressed : null,
              child: _content(context),
            ),
          ),
        ],
      );

  Widget _content(BuildContext context) => Text(
        _buttonText,
        textAlign: TextAlign.center,
      );
}
