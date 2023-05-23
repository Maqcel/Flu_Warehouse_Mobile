import 'dart:developer';

import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/l10n/l10n.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_appbar.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_button.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_qr_scanner.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/edit_action_enum.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/product.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/widgets/product_details_card.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';
import 'package:flu_warehouse_mobile/style/app_duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HomeScannerProductView extends StatefulWidget with ExtensionMixin {
  const HomeScannerProductView({
    super.key,
    required bool isReturnMode,
    required EditActionEnum editAction,
    required bool isScannedWithSuccess,
    required bool isRequestInProgress,
    Uint8List? successImage,
    Product? product,
    required void Function(
      String?,
      Uint8List?,
    )
        onQRCodeScanned,
    required VoidCallback onBackButtonPressed,
    required VoidCallback clearScannedProductPressed,
    required VoidCallback locationEditModePressed,
    required VoidCallback takeProductPressed,
    required VoidCallback projectEditModePressed,
  })  : _isReturnMode = isReturnMode,
        _editAction = editAction,
        _isScannedWithSuccess = isScannedWithSuccess,
        _isRequestInProgress = isRequestInProgress,
        _successImage = successImage,
        _product = product,
        _onQRCodeScanned = onQRCodeScanned,
        _onBackButtonPressed = onBackButtonPressed,
        _clearScannedProductPressed = clearScannedProductPressed,
        _locationEditModePressed = locationEditModePressed,
        _takeProductPressed = takeProductPressed,
        _projectEditModePressed = projectEditModePressed;

  final EditActionEnum _editAction;
  final bool _isScannedWithSuccess;
  final bool _isRequestInProgress;
  final bool _isReturnMode;
  final Uint8List? _successImage;
  final Product? _product;
  final void Function(
    String?,
    Uint8List?,
  ) _onQRCodeScanned;
  final VoidCallback _onBackButtonPressed;
  final VoidCallback _clearScannedProductPressed;
  final VoidCallback _locationEditModePressed;
  final VoidCallback _takeProductPressed;
  final VoidCallback _projectEditModePressed;

  @override
  State<HomeScannerProductView> createState() => _HomeScannerProductViewState();
}

class _HomeScannerProductViewState extends State<HomeScannerProductView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CommonAppbar(
          onBackPressed: widget._onBackButtonPressed,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.ms),
            child: Column(
              children: [
                CommonQrScanner(
                  isScannedWithSuccess: widget._isScannedWithSuccess,
                  successImage: widget._successImage,
                  onDetect: (capture) {
                    log('PRODUCT DETECTED');
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      widget._onQRCodeScanned(
                        barcode.rawValue,
                        capture.image,
                      );
                    }
                  },
                ),
                AnimatedContainer(
                  duration: AppDuration.fast,
                  height: widget._product != null ? AppDimensions.m : 0,
                ),
                ProductDetailsCard(
                  product: widget._product,
                  clearScannedProduct: widget._clearScannedProductPressed,
                ),
                AnimatedContainer(
                  duration: AppDuration.fast,
                  height: widget._product != null ? AppDimensions.m : 0,
                ),
                if (widget._product != null) ..._actionsBuilder(context),
              ],
            ),
          ),
        ),
      );

  List<Widget> _actionsBuilder(BuildContext context) => [
        if (widget._isReturnMode)
          CommonButton(
            buttonText: widget._editAction == EditActionEnum.location
                ? context.l10n.qrScannerScannedProductEditLocationButtonText
                : context.l10n.qrScannerScannedProductEditProjectButtonText,
            isEnabled: !widget._isRequestInProgress,
            onPressed: widget._editAction == EditActionEnum.location
                ? widget._locationEditModePressed
                : widget._projectEditModePressed,
          )
        else
          CommonButton(
            buttonText: context.l10n.qrScannerScannedProductTakeButtonText,
            isEnabled: !widget._isRequestInProgress,
            onPressed: widget._takeProductPressed,
          )
      ];
}
