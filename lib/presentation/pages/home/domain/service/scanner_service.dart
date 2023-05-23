import 'package:flu_warehouse_mobile/app/networking/result.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/get_product_response_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/success_response_dto.dart';

abstract class ScannerService {
  Future<Result<GetProductResponseDto>> getProductData(String productId);

  Future<Result<SuccessResponseDto>> changeProductLocation(
    String productID,
    String locationID,
  );

  Future<Result<SuccessResponseDto>> changeProductProject(
    String productID,
    String projectID,
  );

  Future<Result<SuccessResponseDto>> takeProductFromShelf(
    String productID,
    String userID,
  );
}
