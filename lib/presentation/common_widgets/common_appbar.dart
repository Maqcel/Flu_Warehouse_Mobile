import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';
import 'package:flu_warehouse_mobile/style/app_radius.dart';
import 'package:flutter/material.dart';

class CommonAppbar extends StatelessWidget
    with PreferredSizeWidget, ExtensionMixin {
  const CommonAppbar({
    super.key,
    required VoidCallback onBackPressed,
  }) : _onBackPressed = onBackPressed;

  final VoidCallback _onBackPressed;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.centerLeft,
        height: kToolbarHeight + MediaQuery.of(context).viewPadding.top,
        decoration: BoxDecoration(
          boxShadow: _elevation(context),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(AppRadius.m),
          ),
          color: context.getColors().secondaryBlack100,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(bottom: AppDimensions.s),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _onBackPressed,
                borderRadius: BorderRadius.circular(AppRadius.m * 2),
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.s),
                  child: Icon(
                    Icons.arrow_back,
                    size: AppDimensions.xl,
                    color: context.getColors().primaryWhite,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  List<BoxShadow> _elevation(BuildContext context) => [
        BoxShadow(
          color: context.getColors().primaryYellow25,
          blurRadius: AppRadius.m,
          offset: Offset(
            AppDimensions.zero,
            -AppDimensions.xs,
          ),
        ),
      ];

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
