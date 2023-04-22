import 'package:dio/dio.dart';
import 'package:flu_warehouse_mobile/app/networking/networking_endpoints.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/data/model/login_request_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/data/model/login_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'login_service_api_data_source.g.dart';

@injectable
@RestApi()
abstract class LoginServiceApiDataSource {
  @factoryMethod
  factory LoginServiceApiDataSource(Dio dio) = _LoginServiceApiDataSource;

  @POST(NetworkingEndpoints.login)
  Future<LoginResponseDto> login(@Body() LoginRequestDto requestBody);
}
