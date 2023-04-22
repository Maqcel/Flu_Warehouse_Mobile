import 'package:dio/dio.dart';
import 'package:flu_warehouse_mobile/app/networking/networking_endpoints.dart';
import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/data/model/{{featureName.snakeCase()}}_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part '{{featureName.snakeCase()}}_service_api_data_source.g.dart';

@injectable
@RestApi()
abstract class {{featureName.pascalCase()}}ServiceApiDataSource {
  @factoryMethod
  factory {{featureName.pascalCase()}}ServiceApiDataSource(Dio dio) = _{{featureName.pascalCase()}}ServiceApiDataSource;

  @GET(NetworkingEndpoints.temporaryMason)
  Future<{{featureName.pascalCase()}}Dto> get{{featureName.pascalCase()}}();
}
