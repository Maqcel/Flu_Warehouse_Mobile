import 'package:flu_warehouse_mobile/presentation/pages/home/domain/usecase/get_product.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/cubit/scanner_state.dart';
import 'package:flu_warehouse_mobile/utils/debouncer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ScannerCubit extends Cubit<ScannerState> {
  ScannerCubit({
    required GetProductUseCase getProductUseCase,
  })  : _getProductUseCase = getProductUseCase,
        super(const ScannerState.init());

  final _qrDebouncer = Debouncer(milliseconds: 500);
  final GetProductUseCase _getProductUseCase;

  void init({required bool isReturnMode}) =>
      emit(ScannerState.scanner(isReturnMode: isReturnMode));

  Future<void> onQrCodeDetected(String? qrCode) async =>
      _qrDebouncer.add(() => _getProductFromQrCode(qrCode));

  Future<void> _getProductFromQrCode(String? qrCode) async => state.mapOrNull(
        scanner: (currentState) async {
          if (qrCode != null) {
            (await _getProductUseCase(qrCode)).maybeWhen(
              success: (product) =>
                  emit(currentState.copyWith(scannedProduct: product)),
              failure: (error) => _handleException(
                currentState,
                error.message,
              ),
              orElse: () => null,
            );
          }
          return;
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
