import 'package:json_annotation/json_annotation.dart';

part 'login_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class LoginResponseDto {
  LoginResponseDto({
    required this.token,
    required this.name,
    required this.lastName,
    required this.jobTitle,
    required this.level,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);

  final String token;
  final String name;
  @JsonKey(name: 'lastname')
  final String lastName;
  final String jobTitle;
  final String level;
}
