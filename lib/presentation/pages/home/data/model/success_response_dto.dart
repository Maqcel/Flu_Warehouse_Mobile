import 'package:json_annotation/json_annotation.dart';

part 'success_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class SuccessResponseDto {
  SuccessResponseDto({required this.message});

  factory SuccessResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SuccessResponseDtoFromJson(json);

  final String message;
}
