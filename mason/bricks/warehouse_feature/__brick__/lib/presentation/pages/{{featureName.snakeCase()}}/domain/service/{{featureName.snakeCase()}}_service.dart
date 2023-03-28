import 'package:flu_warehouse_mobile/app/networking/result.dart';
import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/data/model/{{featureName.snakeCase()}}_dto.dart';

abstract class {{featureName.pascalCase()}}Service {
  Future<Result<{{featureName.pascalCase()}}Dto>> get{{featureName.pascalCase()}}Data();
}
