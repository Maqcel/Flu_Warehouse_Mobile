import 'package:flu_warehouse_mobile/app/networking/result.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/data/model/login_request_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/data/model/login_response_dto.dart';

abstract class LoginService {
  Future<Result<LoginResponseDto>> login(LoginRequestDto requestBody);
}
