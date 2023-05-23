import 'package:json_annotation/json_annotation.dart';

part 'take_product_by_user_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class TakeProductByUserRequestDto {
  TakeProductByUserRequestDto({
    required this.productID,
    required this.userID,
  });

  final String productID;
  final String userID;

  Map<String, dynamic> toJson() => _$TakeProductByUserRequestDtoToJson(this);
}
