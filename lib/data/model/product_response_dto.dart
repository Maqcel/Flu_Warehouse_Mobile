import 'package:json_annotation/json_annotation.dart';

part 'product_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class ProductResponseDto {
  ProductResponseDto({
    required this.id,
    required this.name,
    required this.category,
    required this.manufacturer,
    required this.supplier,
    required this.serialNumber,
    required this.locationId,
  });

  factory ProductResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseDtoFromJson(json);

  @JsonKey(name: '_id')
  final String id;

  final String name;

  final String category;

  final String manufacturer;

  final String supplier;

  @JsonKey(name: 'number')
  final String serialNumber;

  @JsonKey(name: 'locationID')
  final String locationId;
}
