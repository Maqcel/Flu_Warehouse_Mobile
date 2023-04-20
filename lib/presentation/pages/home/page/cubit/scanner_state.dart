import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/product.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scanner_state.freezed.dart';

@freezed
class ScannerState with _$ScannerState {
  const factory ScannerState.init() = ScannerStateInit;

  const factory ScannerState.scanner({
    required bool isReturnMode,
    @Default(false) bool isScannedWithSuccess,
    @Default(null) Uint8List? successImage,
    @Default(null) Product? scannedProduct,
  }) = ScannerStateScanner;

  const factory ScannerState.error([String? message]) = ScannerStateError;
}
