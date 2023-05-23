import 'package:flu_warehouse_mobile/app/networking/result.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/service/scanner_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class TakeProductUseCase {
  TakeProductUseCase({
    required ScannerService scannerService,
  }) : _scannerService = scannerService;

  final ScannerService _scannerService;

  Future<Result<bool>> call(String productId, String userId) async =>
      (await _scannerService.takeProductFromShelf(productId, userId)).map(
        success: (data) => const Result.success(true),
        failure: (error) => Result.failure(error.error),
      );
}
