import 'package:auto_route/auto_route.dart';
import 'package:flu_warehouse_mobile/di/dependencies.dart';
import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/l10n/l10n.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_success_dialog.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/actions_enum.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/cubit/home_cubit.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/cubit/home_state.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/view/home_scanner_entry_view.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/view/home_scanner_page.dart';
import 'package:flu_warehouse_mobile/style/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatelessWidget
    implements AutoRouteWrapper, ExtensionMixin {
  const HomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<HomeCubit>(
        create: (BuildContext context) => getIt<HomeCubit>(),
        child: this,
      );

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomeCubit, HomeState>(builder: _builder);

  Widget _builder(BuildContext context, HomeState state) =>
      BlocListener<HomeCubit, HomeState>(
        listener: _listener,
        child: state.maybeWhen(
          scannerEntry: (_) => HomeScannerEntryView(
            onActionButtonPressed: context.read<HomeCubit>().changeHomeScreen,
          ),
          scanningProduct: (
            isReturnMode,
            editAction,
          ) =>
              HomeScannerPage(
            isReturnMode: isReturnMode,
            editAction: editAction,
            onBackButtonPressed: () => context
                .read<HomeCubit>()
                .changeHomeScreen(ActionsEnum.scannerEntry),
            onActionSuccess: () => context
                .read<HomeCubit>()
                .changeHomeScreen(ActionsEnum.scannedWithSuccess),
          ),
          orElse: () => _emptyPlaceholder(context, state),
        ),
      );

  Widget _emptyPlaceholder(
    BuildContext context,
    HomeState homeState,
  ) =>
      GestureDetector(
        onTap: () => context
            .read<HomeCubit>()
            .changeHomeScreen(ActionsEnum.scannerEntry),
        child: Scaffold(
          body: Center(
            child: Text(
              homeState.toString(),
              style: AppTypography.body1.copyWith(
                color: context.getColors().primaryWhite,
              ),
            ),
          ),
        ),
      );

  void _listener(BuildContext context, HomeState state) => state.maybeWhen(
        scannerEntry: (success) =>
            success ? _showActionSuccessDialog(context) : null,
        orElse: () => null,
      );

  void _showActionSuccessDialog(BuildContext context) => showDialog<void>(
        context: context,
        builder: (newContext) => CommonSuccessDialog(
          bodyText: context.l10n.commonSuccessDialogBodyText,
          buttonText: context.l10n.commonSuccessDialogButtonText,
          onButtonPressed: () => Navigator.of(newContext).pop(),
        ),
      );
}
