import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/edit_action_enum.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/location.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/product.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scanner_state.freezed.dart';

@freezed
class ScannerState with _$ScannerState {
  const factory ScannerState.init() = ScannerStateInit;

  const factory ScannerState.scannerProduct({
    required bool isReturnMode,
    required EditActionEnum editAction,
    @Default(false) bool isRequestInProgress,
    @Default(false) bool isScannedWithSuccess,
    @Default(null) Uint8List? successImage,
    @Default(null) Product? scannedProduct,
  }) = ScannerStateScannerProduct;

  const factory ScannerState.scannerLocation({
    required bool isReturnMode,
    @Default(false) bool isScannedWithSuccess,
    @Default(false) bool isRequestInProgress,
    @Default(null) Uint8List? successImage,
    required Product product,
    @Default(null) Location? scannedLocation,
    required ScannerStateScannerProduct previousState,
  }) = ScannerStateScannerLocation;

  const factory ScannerState.scannerProject({
    @Default(false) bool isScannedWithSuccess,
    @Default(false) bool isRequestInProgress,
    @Default(null) Uint8List? successImage,
    required Product product,
    @Default(null) String? scannedProjectId,
    required ScannerStateScannerProduct previousState,
  }) = ScannerStateScannerProject;

  const factory ScannerState.error([String? message]) = ScannerStateError;

  const factory ScannerState.success() = ScannerStateSuccess;
}
