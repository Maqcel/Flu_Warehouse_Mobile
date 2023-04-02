import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/generated/assets/assets.gen.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';
import 'package:flu_warehouse_mobile/style/app_radius.dart';
import 'package:flu_warehouse_mobile/style/app_typography.dart';
import 'package:flutter/material.dart';

class CommonCard extends StatelessWidget with ExtensionMixin {
  const CommonCard({
    super.key,
    Widget? headerWidget,
    String? headerText,
    required Widget bodyWidget,
    void Function()? onCloseActionPressed,
  })  : _headerWidget = headerWidget,
        _headerText = headerText ?? '',
        _bodyWidget = bodyWidget,
        _onCloseActionPressed = onCloseActionPressed,
        assert(
          (headerText == null && headerWidget != null) ||
              (headerWidget == null && headerText != null),
          'HeaderText or HeaderWidget must be provided with CommonCard',
        );

  final Widget? _headerWidget;
  final String _headerText;
  final Widget _bodyWidget;
  final VoidCallback? _onCloseActionPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(AppDimensions.xs),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.m)),
            color: context.getColors().primaryWhite,
            boxShadow: context.getShadows(),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _headerSection(context),
              _bodySection(context),
            ],
          ),
        ),
      );

  Widget _headerSection(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.m)),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.getColors().secondaryGrey,
            boxShadow: context.getShadows(),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppDimensions.xm,
              horizontal: AppDimensions.ms,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_headerText.isNotEmpty)
                  Expanded(
                    child: Text(
                      _headerText,
                      style: AppTypography.header1,
                    ),
                  )
                else
                  _headerWidget ?? const SizedBox.shrink(),
                if (_onCloseActionPressed != null) _closeActionButton(context),
              ],
            ),
          ),
        ),
      );

  Widget _closeActionButton(BuildContext context) => Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.m),
          onTap: _onCloseActionPressed,
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.xs),
            child: Assets.icons.close.svg(),
          ),
        ),
      );

  Widget _bodySection(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [Expanded(child: _bodyWidget)],
      );
}
