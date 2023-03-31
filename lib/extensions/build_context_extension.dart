import 'package:flu_warehouse_mobile/app/networking/failure.dart';
import 'package:flu_warehouse_mobile/l10n/l10n.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_button.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';
import 'package:flu_warehouse_mobile/style/app_typography.dart';
import 'package:flu_warehouse_mobile/style/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

extension ContextProvider on BuildContext {
  AppTheme getColors({bool listen = true}) =>
      Provider.of<ThemeModel>(this, listen: listen).getTheme;

  void showError(Failure failure) => ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            failure.message ?? l10n.errorResponseNotIncluded,
            style: AppTypography.header2
                .copyWith(color: getColors(listen: false).primaryWhite),
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
          backgroundColor: getColors(listen: false).secondaryBlack100,
        ),
      );

  Future<void> showSuccess({
    required Widget dialogContent,
    required String buttonText,
  }) =>
      showDialog<void>(
        context: this,
        builder: (context) => _successDialog(
          context,
          dialogContent,
          buttonText,
        ),
      );

  Dialog _successDialog(
    BuildContext context,
    Widget dialogContent,
    String buttonText,
  ) {
    final double dialogRadius = 10.r;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(dialogRadius)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          dialogContent,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.l),
            child: Column(
              children: [
                CommonButton(
                  buttonText: buttonText,
                  isEnabled: true,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                SizedBox(height: AppDimensions.l),
              ],
            ),
          ),
        ],
      ),
    );
  }
}