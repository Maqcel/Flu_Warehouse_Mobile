import 'package:flu_warehouse_mobile/di/dependencies.dart';
import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/cubit/scanner_cubit.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/cubit/scanner_state.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/view/home_scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScannerPage extends StatelessWidget {
  const HomeScannerPage({
    super.key,
    required bool isReturnMode,
  }) : _isReturnMode = isReturnMode;

  final bool _isReturnMode;

  @override
  Widget build(BuildContext context) => BlocProvider<ScannerCubit>(
        create: (_) => getIt<ScannerCubit>()..init(isReturnMode: _isReturnMode),
        child: const HomeScannerWrappedPage(),
      );
}

class HomeScannerWrappedPage extends StatefulWidget with ExtensionMixin {
  const HomeScannerWrappedPage({super.key});

  @override
  State<HomeScannerWrappedPage> createState() => _HomeScannerWrappedPageState();
}

class _HomeScannerWrappedPageState extends State<HomeScannerWrappedPage> {
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ScannerCubit, ScannerState>(
        buildWhen: _buildWhen,
        builder: _builder,
        listener: _listener,
      );

  bool _buildWhen(ScannerState previous, ScannerState current) =>
      current != const ScannerState.error();

  Widget _builder(BuildContext context, ScannerState state) =>
      const HomeScannerView();

  void _listener(BuildContext context, ScannerState state) => state.maybeWhen(
        error: (error) => context.showError(error),
        orElse: () => null,
      );
}
