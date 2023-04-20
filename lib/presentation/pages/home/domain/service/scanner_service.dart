import 'package:flu_warehouse_mobile/app/networking/result.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/get_product_response_dto.dart';

abstract class ScannerService {
  Future<Result<GetProductResponseDto>> getProductData(String productId);
}
