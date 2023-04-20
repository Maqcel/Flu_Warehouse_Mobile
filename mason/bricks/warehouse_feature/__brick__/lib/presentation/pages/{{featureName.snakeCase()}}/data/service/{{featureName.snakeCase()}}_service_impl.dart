import 'package:flu_warehouse_mobile/app/networking/handle_api_exceptions.dart';
import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/data/data_source/{{featureName.snakeCase()}}_service_api_data_source.dart';
import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/data/model/{{featureName.snakeCase()}}_dto.dart';
import 'package:flu_warehouse_mobile/app/networking/result.dart';
import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/domain/service/{{featureName.snakeCase()}}_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: {{featureName.pascalCase()}}Service)
class {{featureName.pascalCase()}}ServiceImpl implements {{featureName.pascalCase()}}Service {
  {{featureName.pascalCase()}}ServiceImpl({
    required {{featureName.pascalCase()}}ApiDataSource dataSource,
  }): _dataSource = dataSource;

  final {{featureName.pascalCase()}}ApiDataSource _dataSource;

  @override
  Future<Result<{{featureName.pascalCase()}}Dto>> get{{featureName.pascalCase()}}() async =>
        _dataSource
          .get{{featureName.pascalCase()}}()
          .then(Result<{{featureName.pascalCase()}}Dto>.success)
          .catchError(HandleApiExceptions.handleError<{{featureName.pascalCase()}}Dto>);
}
