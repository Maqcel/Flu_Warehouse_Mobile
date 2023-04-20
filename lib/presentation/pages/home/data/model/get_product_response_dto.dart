import 'package:json_annotation/json_annotation.dart';

part 'get_product_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class GetProductResponseDto {
  GetProductResponseDto({required this.id});

  factory GetProductResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetProductResponseDtoFromJson(json);

  final String id;
}
