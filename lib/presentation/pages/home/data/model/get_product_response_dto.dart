import 'package:flu_warehouse_mobile/data/model/location_response_dto.dart';
import 'package:flu_warehouse_mobile/data/model/product_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_product_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class GetProductResponseDto {
  GetProductResponseDto({
    required this.product,
    required this.location,
  });

  factory GetProductResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetProductResponseDtoFromJson(json);

  final List<ProductResponseDto> product;
  final LocationResponseDto? location;
}
