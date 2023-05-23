import 'package:json_annotation/json_annotation.dart';

part 'transfer_product_location_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class TransferProductLocationRequestDto {
  TransferProductLocationRequestDto({
    required this.productID,
    required this.locationID,
  });

  final String productID;

  final String locationID;

  Map<String, dynamic> toJson() =>
      _$TransferProductLocationRequestDtoToJson(this);
}
