import 'package:flu_warehouse_mobile/app/networking/handle_api_exceptions.dart';
import 'package:flu_warehouse_mobile/app/networking/result.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/data/data_source/login_service_api_data_source.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/data/model/login_request_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/data/model/login_response_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/domain/service/login_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginService)
class LoginServiceImpl implements LoginService {
  LoginServiceImpl({
    required LoginServiceApiDataSource dataSource,
  }) : _dataSource = dataSource;

  final LoginServiceApiDataSource _dataSource;

  @override
  Future<Result<LoginResponseDto>> login(LoginRequestDto requestBody) async =>
      _dataSource
          .login(requestBody)
          .then(Result<LoginResponseDto>.success)
          .catchError(HandleApiExceptions.handleError<LoginResponseDto>);
}
