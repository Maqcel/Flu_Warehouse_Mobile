import 'dart:developer';

import 'package:flu_warehouse_mobile/l10n/l10n.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_appbar.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_button.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_qr_scanner.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/location.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/product.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/widgets/location_details_card.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HomeScannerLocationView extends StatefulWidget {
  const HomeScannerLocationView({
    super.key,
    required bool isScannedWithSuccess,
    required bool isRequestInProgress,
    required Product scannedProduct,
    Uint8List? successImage,
    Location? scannedLocation,
    required void Function(
      String?,
      Uint8List?,
    )
        onQRCodeScanned,
    required VoidCallback onBackButtonPressed,
    required VoidCallback clearScannedLocationPressed,
    required VoidCallback confirmLocationPressed,
  })  : _isScannedWithSuccess = isScannedWithSuccess,
        _isRequestInProgress = isRequestInProgress,
        _scannedProduct = scannedProduct,
        _successImage = successImage,
        _scannedLocation = scannedLocation,
        _onQRCodeScanned = onQRCodeScanned,
        _onBackButtonPressed = onBackButtonPressed,
        _clearScannedLocationPressed = clearScannedLocationPressed,
        _confirmLocationPressed = confirmLocationPressed;

  final bool _isScannedWithSuccess;
  final bool _isRequestInProgress;
  final Product _scannedProduct;
  final Uint8List? _successImage;
  final Location? _scannedLocation;
  final void Function(
    String?,
    Uint8List?,
  ) _onQRCodeScanned;
  final VoidCallback _onBackButtonPressed;
  final VoidCallback _clearScannedLocationPressed;
  final VoidCallback _confirmLocationPressed;

  @override
  State<HomeScannerLocationView> createState() =>
      _HomeScannerLocationViewState();
}

class _HomeScannerLocationViewState extends State<HomeScannerLocationView> {
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
                    log('DETECT LOCATION');
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
                LocationDetailsCard(
                  productName: widget._scannedProduct.name,
                  currentLocation: widget._scannedProduct.location.id,
                  location: widget._scannedLocation,
                  clearScannedLocation: widget._clearScannedLocationPressed,
                ),
                SizedBox(height: AppDimensions.m),
                CommonButton(
                  buttonText: context
                      .l10n.qrScannerScannedProductConfirmLocationButtonText,
                  isEnabled: widget._scannedLocation != null &&
                      !widget._isRequestInProgress,
                  onPressed: widget._confirmLocationPressed,
                ),
              ],
            ),
          ),
        ),
      );
}
