import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/get_product_response_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/product.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductResponseDtoToProductMapper {
  Product call(GetProductResponseDto dto) => Product();
}
