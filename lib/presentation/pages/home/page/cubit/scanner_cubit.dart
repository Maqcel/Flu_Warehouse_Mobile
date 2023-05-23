import 'dart:developer';

import 'package:flu_warehouse_mobile/domain/usecase/user/get_user.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/edit_action_enum.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/location.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/usecase/change_project.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/usecase/get_product.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/usecase/take_product.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/usecase/transfer_product.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/cubit/scanner_state.dart';
import 'package:flu_warehouse_mobile/style/app_duration.dart';
import 'package:flu_warehouse_mobile/utils/debouncer.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ScannerCubit extends Cubit<ScannerState> {
  ScannerCubit({
    required GetUserUseCase getUserUseCase,
    required GetProductUseCase getProductUseCase,
    required TakeProductUseCase takeProductUseCase,
    required TransferProductUseCase transferProductUseCase,
    required ChangeProjectUseCase changeProjectUseCase,
  })  : _getUserUseCase = getUserUseCase,
        _getProductUseCase = getProductUseCase,
        _takeProductUseCase = takeProductUseCase,
        _transferProductUseCase = transferProductUseCase,
        _changeProjectUseCase = changeProjectUseCase,
        super(const ScannerState.init());

  final _qrDebouncer = Debouncer(milliseconds: 500);
  final GetUserUseCase _getUserUseCase;
  final GetProductUseCase _getProductUseCase;
  final TakeProductUseCase _takeProductUseCase;
  final TransferProductUseCase _transferProductUseCase;
  final ChangeProjectUseCase _changeProjectUseCase;

  Future<void> init({
    required bool isReturnMode,
    required EditActionEnum editAction,
  }) async =>
      emit(
        ScannerState.scannerProduct(
          isReturnMode: isReturnMode,
          editAction: editAction,
        ),
      );

  void switchToLocationEditMode() => state.mapOrNull(
        scannerProduct: (currentState) => emit(
          ScannerState.scannerLocation(
            isReturnMode: currentState.isReturnMode,
            product: currentState.scannedProduct!,
            previousState: currentState,
          ),
        ),
      );

  void switchToProjectEditMode() => state.mapOrNull(
        scannerProduct: (currentState) => emit(
          ScannerState.scannerProject(
            product: currentState.scannedProduct!,
            previousState: currentState,
          ),
        ),
      );

  void switchBackToProductMode() => state.mapOrNull(
        scannerLocation: (currentState) => emit(currentState.previousState),
        scannerProject: (currentState) => emit(currentState.previousState),
      );

  Future<void> onQrCodeDetected(
    String? qrCode,
    Uint8List? image,
  ) async =>
      _qrDebouncer.add(
        () => _getProductFromQrCode(
          qrCode,
          image,
        ),
      );

  Future<void> _getProductFromQrCode(
    String? qrCode,
    Uint8List? image,
  ) async =>
      state.mapOrNull(
        scannerProduct: (currentState) async {
          if (qrCode != null && !currentState.isRequestInProgress) {
            log('Scanned product: $qrCode');
            emit(currentState.copyWith(isRequestInProgress: true));
            (await _getProductUseCase(qrCode)).maybeWhen(
              success: (product) async {
                emit(currentState.copyWith(isScannedWithSuccess: true));
                await Future<void>.delayed(AppDuration.regular);
                emit(
                  currentState.copyWith(
                    successImage: image,
                    scannedProduct: product,
                    isRequestInProgress: false,
                  ),
                );
              },
              failure: (error) => _handleException(
                currentState.copyWith(isRequestInProgress: false),
                error.message,
              ),
              orElse: () => null,
            );
          }
          return;
        },
      );

  Future<void> getLocationFromQrCode(
    String? qrCode,
    Uint8List? image,
  ) async =>
      state.mapOrNull(
        scannerLocation: (currentState) async {
          if (qrCode != null) {
            log('Scanned location: $qrCode');
            emit(currentState.copyWith(isScannedWithSuccess: true));
            await Future<void>.delayed(AppDuration.regular);
            emit(
              currentState.copyWith(
                successImage: image,
                scannedLocation: Location(id: qrCode),
              ),
            );
          }
          return;
        },
      );

  Future<void> getProjectFromQrCode(
    String? qrCode,
    Uint8List? image,
  ) async =>
      state.mapOrNull(
        scannerProject: (currentState) async {
          if (qrCode != null) {
            log('Scanned project: $qrCode');
            emit(currentState.copyWith(isScannedWithSuccess: true));
            await Future<void>.delayed(AppDuration.regular);
            emit(
              currentState.copyWith(
                successImage: image,
                scannedProjectId: qrCode,
              ),
            );
          }
          return;
        },
      );

  void clearScannedItem() => state.mapOrNull(
        scannerProduct: (currentState) => emit(
          currentState.copyWith(
            isScannedWithSuccess: false,
            isRequestInProgress: false,
            scannedProduct: null,
            successImage: null,
          ),
        ),
        scannerLocation: (currentState) => emit(
          currentState.copyWith(
            isScannedWithSuccess: false,
            isRequestInProgress: false,
            scannedLocation: null,
            successImage: null,
          ),
        ),
        scannerProject: (currentState) => emit(
          currentState.copyWith(
            isScannedWithSuccess: false,
            isRequestInProgress: false,
            scannedProjectId: null,
            successImage: null,
          ),
        ),
      );

  Future<void> takeProduct() async => state.mapOrNull(
        scannerProduct: (currentState) async {
          emit(currentState.copyWith(isRequestInProgress: true));
          return (await _takeProductUseCase(
            currentState.scannedProduct!.id,
            (await _getUserUseCase())!,
          ))
              .maybeWhen(
            success: (_) => emit(const ScannerState.success()),
            failure: (error) => _handleException(
              currentState.copyWith(isRequestInProgress: false),
              error.message,
            ),
            orElse: () => null,
          );
        },
      );

  Future<void> changeProductLocation() async => state.mapOrNull(
        scannerLocation: (currentState) async {
          emit(currentState.copyWith(isRequestInProgress: true));
          return (await _transferProductUseCase(
            currentState.product.id,
            currentState.scannedLocation!.id,
          ))
              .maybeWhen(
            success: (_) => emit(const ScannerState.success()),
            failure: (error) => _handleException(
              currentState.copyWith(isRequestInProgress: false),
              error.message,
            ),
            orElse: () => null,
          );
        },
      );

  Future<void> changeProductProject() async => state.mapOrNull(
        scannerProject: (currentState) async {
          emit(currentState.copyWith(isRequestInProgress: true));
          return (await _changeProjectUseCase(
            currentState.product.id,
            currentState.scannedProjectId!,
          ))
              .maybeWhen(
            success: (_) => emit(const ScannerState.success()),
            failure: (error) => _handleException(
              currentState.copyWith(isRequestInProgress: false),
              error.message,
            ),
            orElse: () => null,
          );
        },
      );

  void _handleException(ScannerState currentState, String? message) {
    emit(ScannerState.error(message));
    emit(currentState);
  }

  @override
  Future<void> close() {
    _qrDebouncer.cancel();
    return super.close();
  }
}
