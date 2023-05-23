import 'dart:developer';

import 'package:flu_warehouse_mobile/l10n/l10n.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_appbar.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_button.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_qr_scanner.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/product.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/widgets/project_details_card.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HomeScannerProjectView extends StatefulWidget {
  const HomeScannerProjectView({
    super.key,
    required bool isScannedWithSuccess,
    required bool isRequestInProgress,
    required Product scannedProduct,
    Uint8List? successImage,
    String? scannedProject,
    required void Function(
      String?,
      Uint8List?,
    )
        onQRCodeScanned,
    required VoidCallback onBackButtonPressed,
    required VoidCallback clearScannedProjectPressed,
    required VoidCallback confirmProjectPressed,
  })  : _isScannedWithSuccess = isScannedWithSuccess,
        _isRequestInProgress = isRequestInProgress,
        _scannedProduct = scannedProduct,
        _successImage = successImage,
        _scannedProject = scannedProject,
        _onQRCodeScanned = onQRCodeScanned,
        _onBackButtonPressed = onBackButtonPressed,
        _clearScannedProjectPressed = clearScannedProjectPressed,
        _confirmProjectPressed = confirmProjectPressed;

  final bool _isScannedWithSuccess;
  final bool _isRequestInProgress;
  final Product _scannedProduct;
  final Uint8List? _successImage;
  final String? _scannedProject;
  final void Function(
    String?,
    Uint8List?,
  ) _onQRCodeScanned;
  final VoidCallback _onBackButtonPressed;
  final VoidCallback _clearScannedProjectPressed;
  final VoidCallback _confirmProjectPressed;

  @override
  State<HomeScannerProjectView> createState() => _HomeScannerProjectViewState();
}

class _HomeScannerProjectViewState extends State<HomeScannerProjectView> {
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
                    log('DETECT PROJECT');
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      widget._onQRCodeScanned(
                        barcode.rawValue,
                        capture.image,
                      );
                    }
                  },
                ),
                SizedBox(height: AppDimensions.m),
                ProjectDetailsCard(
                  productName: widget._scannedProduct.name,
                  currentProject: widget._scannedProduct.location.id,
                  project: widget._scannedProject,
                  clearScannedProject: widget._clearScannedProjectPressed,
                ),
                SizedBox(height: AppDimensions.m),
                CommonButton(
                  buttonText: context
                      .l10n.qrScannerScannedProductConfirmProjectButtonText,
                  isEnabled: widget._scannedProject != null &&
                      !widget._isRequestInProgress,
                  onPressed: widget._confirmProjectPressed,
                ),
              ],
            ),
          ),
        ),
      );
}
