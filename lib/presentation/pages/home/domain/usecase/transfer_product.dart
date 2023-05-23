import 'package:flu_warehouse_mobile/app/networking/result.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/service/scanner_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class TransferProductUseCase {
  TransferProductUseCase({
    required ScannerService scannerService,
  }) : _scannerService = scannerService;

  final ScannerService _scannerService;

  Future<Result<bool>> call(String productId, String locationId) async =>
      (await _scannerService.changeProductLocation(productId, locationId)).map(
        success: (data) => const Result.success(true),
        failure: (error) => Result.failure(error.error),
      );
}
