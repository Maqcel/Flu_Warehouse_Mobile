import 'package:auto_route/auto_route.dart';
import 'package:flu_warehouse_mobile/di/dependencies.dart';
import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/actions_enum.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/cubit/home_cubit.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/cubit/home_state.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/view/home_scanner_entry_view.dart';
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

  Widget _builder(BuildContext context, HomeState state) => state.maybeWhen(
        scannerEntry: () => HomeScannerEntryView(
          onActionButtonPressed: context.read<HomeCubit>().changeHomeScreen,
        ),
        scanningProduct: (isReturnMode) => _emptyPlaceholder(context, state),
        productFound: () => _emptyPlaceholder(context, state),
        localizationEdit: (isReturnMode) => _emptyPlaceholder(context, state),
        orElse: () => _emptyPlaceholder(context, state),
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
}
