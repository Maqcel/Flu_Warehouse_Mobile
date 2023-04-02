import 'package:flu_warehouse_mobile/l10n/l10n.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_button.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_card.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/actions_enum.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';
import 'package:flu_warehouse_mobile/style/app_typography.dart';
import 'package:flutter/material.dart';

class HomeScannerEntryView extends StatelessWidget {
  const HomeScannerEntryView({
    super.key,
    required void Function(ActionsEnum) onActionButtonPressed,
  }) : _onActionButtonPressed = onActionButtonPressed;

  final void Function(ActionsEnum) _onActionButtonPressed;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ..._actionSectionBuilder(
                  context: context,
                  headerText: context.l10n.scannerEntryReturnHeaderText,
                  bodyText: context.l10n.scannerEntryReturnBodyText,
                  actionButtonText: context.l10n.scannerEntryActionButtonText,
                  onActionButtonPressed: () =>
                      _onActionButtonPressed(ActionsEnum.scannerReturn),
                ),
                ..._actionSectionBuilder(
                  context: context,
                  headerText: context.l10n.scannerEntryGetProductHeaderText,
                  bodyText: context.l10n.scannerEntryGetProductBodyText,
                  actionButtonText: context.l10n.scannerEntryActionButtonText,
                  onActionButtonPressed: () =>
                      _onActionButtonPressed(ActionsEnum.scannerTake),
                ),
              ],
            ),
          ),
        ),
      );

  List<Widget> _actionSectionBuilder({
    required BuildContext context,
    required String headerText,
    required String bodyText,
    required String actionButtonText,
    required VoidCallback onActionButtonPressed,
  }) =>
      [
        _buildActionCard(
          context: context,
          headerText: headerText,
          bodyText: bodyText,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.ms),
          child: CommonButton(
            buttonText: actionButtonText,
            isEnabled: true,
            onPressed: onActionButtonPressed,
          ),
        ),
      ];

  Widget _buildActionCard({
    required BuildContext context,
    required String headerText,
    required String bodyText,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.m,
          vertical: AppDimensions.ms,
        ),
        child: CommonCard(
          headerText: headerText,
          bodyWidget: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.ms,
              vertical: AppDimensions.xm,
            ),
            child: Text(
              bodyText,
              style: AppTypography.body1,
            ),
          ),
        ),
      );
}
