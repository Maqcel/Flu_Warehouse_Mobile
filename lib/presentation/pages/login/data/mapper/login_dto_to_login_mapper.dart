import 'package:flu_warehouse_mobile/presentation/pages/login/data/model/login_response_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/domain/model/login.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginDtoToLoginMapper {
  Login call(LoginResponseDto dto) => Login(
        token: dto.token,
        name: dto.name,
        lastName: dto.lastName,
        jobTitle: dto.jobTitle,
        level: dto.level,
      );
}
