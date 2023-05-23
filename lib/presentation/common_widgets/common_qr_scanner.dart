import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/generated/assets/assets.gen.dart';
import 'package:flu_warehouse_mobile/l10n/l10n.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';
import 'package:flu_warehouse_mobile/style/app_radius.dart';
import 'package:flu_warehouse_mobile/style/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CommonQrScanner extends StatefulWidget with ExtensionMixin {
  const CommonQrScanner({
    super.key,
    required bool isScannedWithSuccess,
    Uint8List? successImage,
    required void Function(BarcodeCapture) onDetect,
  })  : _isScannedWithSuccess = isScannedWithSuccess,
        _successImage = successImage,
        _onDetect = onDetect;

  final bool _isScannedWithSuccess;
  final Uint8List? _successImage;
  final void Function(BarcodeCapture) _onDetect;

  @override
  State<CommonQrScanner> createState() => _CommonQrScannerState();
}

class _CommonQrScannerState extends State<CommonQrScanner> {
  final Key qrScannerKey = GlobalKey(debugLabel: 'QR');
  final MobileScannerController _controller = MobileScannerController();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller.stop();
    } else if (Platform.isIOS) {
      _controller.start();
    }
  }

  @override
  Widget build(BuildContext context) => Expanded(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: _scannerRadius(),
                color: widget._isScannedWithSuccess
                    ? context.getColors().primaryYellow100
                    : context.getColors().primaryBlack100,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppDimensions.xxs),
              child: ClipRRect(
                borderRadius: _scannerRadius(),
                child: widget._successImage == null
                    ? MobileScanner(
                        controller: _controller,
                        onDetect: widget._isScannedWithSuccess
                            ? (_) => {}
                            : widget._onDetect,
                      )
                    : Transform.rotate(
                        angle: 90 * pi / 180,
                        child: Image.memory(
                          widget._successImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            Positioned(
              bottom: AppDimensions.ms,
              child: _scannerLabel(context),
            ),
          ],
        ),
      );

  BorderRadius _scannerRadius() => BorderRadius.circular(AppRadius.m);

  Widget _scannerLabel(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: _scannerRadius(),
          color: widget._isScannedWithSuccess
              ? context.getColors().primaryYellow100
              : context.getColors().primaryGrey,
        ),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.xm),
          child: Row(
            children: [
              if (widget._isScannedWithSuccess) ...[
                Assets.icons.checkmark.svg(height: AppDimensions.m),
                SizedBox(width: AppDimensions.xm),
              ],
              Text(
                widget._successImage != null
                    ? context.l10n.qrScannerScanningSuccess
                    : context.l10n.qrScannerScanningProgress,
                style: AppTypography.body2
                    .copyWith(color: context.getColors().primaryBlack100),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
