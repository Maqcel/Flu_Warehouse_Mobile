import 'package:flu_warehouse_mobile/app/networking/api_client.dart';
import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/data/model/{{featureName.snakeCase()}}_dto.dart';
import 'package:flu_warehouse_mobile/app/networking/result.dart';
import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/domain/service/{{featureName.snakeCase()}}_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: {{featureName.pascalCase()}}Service)
class {{featureName.pascalCase()}}ServiceImpl implements {{featureName.pascalCase()}}Service {
  {{featureName.pascalCase()}}ServiceImpl({
    required ApiClient apiClient
  }): _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<Result<{{featureName.pascalCase()}}Dto>> get{{featureName.pascalCase()}}Data() async {
    // TODO: Implement {{featureName.pascalCase()}} fetch
    throw UnimplementedError();
  }
}
