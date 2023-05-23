import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/get_product_response_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/location.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/product.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductResponseDtoToProductMapper {
  Product call(GetProductResponseDto dto) => Product(
        id: dto.product.first.id,
        name: dto.product.first.name,
        category: dto.product.first.category,
        manufacturer: dto.product.first.manufacturer,
        supplier: dto.product.first.supplier,
        serialNumber: dto.product.first.serialNumber,
        location: Location(
          id: dto.location?.id ?? '1',
          rackNumber: dto.location?.location?.rack,
          shelfNumber: dto.location?.location?.shelf,
          firstName: dto.location?.name,
          lastName: dto.location?.lastname,
        ),
      );
}
