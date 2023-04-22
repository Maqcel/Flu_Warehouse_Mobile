import 'package:flu_warehouse_mobile/app/networking/result.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/data/mapper/login_dto_to_login_mapper.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/data/model/login_request_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/domain/model/login.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/domain/service/login_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  LoginUseCase({
    required LoginService loginService,
    required LoginDtoToLoginMapper loginMapper,
  })  : _loginService = loginService,
        _loginMapper = loginMapper;

  final LoginService _loginService;
  final LoginDtoToLoginMapper _loginMapper;

  Future<Result<Login>> call({
    required String login,
    required String password,
  }) async =>
      (await _loginService.login(
        LoginRequestDto(
          password: password,
          login: login,
        ),
      ))
          .map(
        success: (dto) => Result.success(_loginMapper(dto.value)),
        failure: (error) => Result.failure(error.error),
      );
}
