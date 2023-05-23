import 'package:flu_warehouse_mobile/app/networking/result.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/service/scanner_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangeProjectUseCase {
  ChangeProjectUseCase({
    required ScannerService scannerService,
  }) : _scannerService = scannerService;

  final ScannerService _scannerService;

  Future<Result<bool>> call(String productId, String projectId) async =>
      (await _scannerService.changeProductProject(productId, projectId)).map(
        success: (data) => const Result.success(true),
        failure: (error) => Result.failure(error.error),
      );
}
