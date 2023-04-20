import 'package:flu_warehouse_mobile/app/networking/result.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/mapper/get_product_response_dto_to_product_mapper.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/product.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/service/scanner_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductUseCase {
  GetProductUseCase({
    required ScannerService scannerService,
    required GetProductResponseDtoToProductMapper productMapper,
  })  : _scannerService = scannerService,
        _productMapper = productMapper;

  final ScannerService _scannerService;
  final GetProductResponseDtoToProductMapper _productMapper;

  Future<Result<Product>> call(String productId) async =>
      (await _scannerService.getProductData(productId)).map(
        success: (data) => Result.success(_productMapper(data.value)),
        failure: (error) => Result.failure(error.error),
      );
}
