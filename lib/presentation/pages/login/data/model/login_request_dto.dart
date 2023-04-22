import 'package:json_annotation/json_annotation.dart';

part 'login_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class LoginRequestDto {
  LoginRequestDto({
    required this.password,
    required this.login,
  });

  final String password;
  final String login;

  Map<String, dynamic> toJson() => _$LoginRequestDtoToJson(this);
}
