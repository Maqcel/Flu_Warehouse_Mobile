import 'package:flu_warehouse_mobile/app/networking/handle_api_exceptions.dart';
import 'package:flu_warehouse_mobile/app/networking/result.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/data_source/scanner_service_api_data_source.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/get_product_response_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/service/scanner_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ScannerService)
class ScannerServiceImpl implements ScannerService {
  ScannerServiceImpl({
    required ScannerServiceApiDataSource dataSource,
  }) : _dataSource = dataSource;

  final ScannerServiceApiDataSource _dataSource;

  @override
  Future<Result<GetProductResponseDto>> getProductData(String productId) =>
      _dataSource
          .getProductData(productId)
          .then(Result<GetProductResponseDto>.success)
          .catchError(HandleApiExceptions.handleError<GetProductResponseDto>);
}
