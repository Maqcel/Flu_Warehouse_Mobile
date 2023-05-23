import 'package:flu_warehouse_mobile/di/dependencies.dart';
import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_loading_widget.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/edit_action_enum.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/cubit/scanner_cubit.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/cubit/scanner_state.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/view/home_scanner_location_view.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/view/home_scanner_product_view.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/view/home_scanner_project_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScannerPage extends StatelessWidget {
  const HomeScannerPage({
    super.key,
    required bool isReturnMode,
    required EditActionEnum editAction,
    required VoidCallback onBackButtonPressed,
    required VoidCallback onActionSuccess,
  })  : _isReturnMode = isReturnMode,
        _editAction = editAction,
        _onBackButtonPressed = onBackButtonPressed,
        _onActionSuccess = onActionSuccess;

  final bool _isReturnMode;
  final EditActionEnum _editAction;
  final VoidCallback _onBackButtonPressed;
  final VoidCallback _onActionSuccess;

  @override
  Widget build(BuildContext context) => BlocProvider<ScannerCubit>(
        create: (_) => getIt<ScannerCubit>()
          ..init(
            isReturnMode: _isReturnMode,
            editAction: _editAction,
          ),
        child: HomeScannerWrappedPage(
          onBackButtonPressed: _onBackButtonPressed,
          onActionSuccess: _onActionSuccess,
        ),
      );
}

class HomeScannerWrappedPage extends StatefulWidget with ExtensionMixin {
  const HomeScannerWrappedPage({
    super.key,
    required VoidCallback onBackButtonPressed,
    required VoidCallback onActionSuccess,
  })  : _onBackButtonPressed = onBackButtonPressed,
        _onActionSuccess = onActionSuccess;

  final VoidCallback _onBackButtonPressed;
  final VoidCallback _onActionSuccess;

  @override
  State<HomeScannerWrappedPage> createState() => _HomeScannerWrappedPageState();
}

class _HomeScannerWrappedPageState extends State<HomeScannerWrappedPage> {
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ScannerCubit, ScannerState>(
        buildWhen: _buildWhen,
        builder: (context, state) => state.maybeMap(
          init: (_) => _loadingBody(),
          scannerProduct: (scannerState) => _builderProduct(
            context,
            scannerState,
          ),
          scannerLocation: (scannerState) => _builderLocation(
            context,
            scannerState,
          ),
          orElse: _loadingBody,
        ),
        listener: _listener,
      );

  bool _buildWhen(ScannerState previous, ScannerState current) =>
      current != const ScannerState.error() &&
      current != const ScannerState.success();

  Widget _loadingBody() =>
      const Scaffold(body: Center(child: CommonLoadingWidget()));

  Widget _builderProduct(
    BuildContext context,
    ScannerStateScannerProduct state,
  ) =>
      HomeScannerProductView(
        isReturnMode: state.isReturnMode,
        isScannedWithSuccess: state.isScannedWithSuccess,
        editAction: state.editAction,
        isRequestInProgress: state.isRequestInProgress,
        successImage: state.successImage,
        product: state.scannedProduct,
        onQRCodeScanned: context.read<ScannerCubit>().onQrCodeDetected,
        onBackButtonPressed: widget._onBackButtonPressed,
        clearScannedProductPressed:
            context.read<ScannerCubit>().clearScannedItem,
        locationEditModePressed:
            context.read<ScannerCubit>().switchToLocationEditMode,
        projectEditModePressed:
            context.read<ScannerCubit>().switchToProjectEditMode,
        takeProductPressed: context.read<ScannerCubit>().takeProduct,
      );

  Widget _builderLocation(
    BuildContext context,
    ScannerStateScannerLocation state,
  ) =>
      HomeScannerLocationView(
        isScannedWithSuccess: state.isScannedWithSuccess,
        isRequestInProgress: state.isRequestInProgress,
        scannedProduct: state.product,
        successImage: state.successImage,
        scannedLocation: state.scannedLocation,
        onQRCodeScanned: context.read<ScannerCubit>().getLocationFromQrCode,
        onBackButtonPressed:
            context.read<ScannerCubit>().switchBackToProductMode,
        clearScannedLocationPressed:
            context.read<ScannerCubit>().clearScannedItem,
        confirmLocationPressed:
            context.read<ScannerCubit>().changeProductLocation,
      );

  Widget _builderProject(
    BuildContext context,
    ScannerStateScannerProject state,
  ) =>
      HomeScannerProjectView(
        isScannedWithSuccess: state.isScannedWithSuccess,
        isRequestInProgress: state.isRequestInProgress,
        scannedProduct: state.product,
        onQRCodeScanned: context.read<ScannerCubit>().getProjectFromQrCode,
        onBackButtonPressed:
            context.read<ScannerCubit>().switchBackToProductMode,
        clearScannedProjectPressed:
            context.read<ScannerCubit>().clearScannedItem,
        confirmProjectPressed:
            context.read<ScannerCubit>().changeProductProject,
      );

  void _listener(BuildContext context, ScannerState state) => state.maybeWhen(
        success: () => widget._onActionSuccess(),
        error: (error) => context.showError(error),
        orElse: () => null,
      );
}
