import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/data/model/{{featureName.snakeCase()}}_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/domain/model/{{featureName.snakeCase()}}.dart';
import 'package:injectable/injectable.dart';

@injectable
class {{featureName.pascalCase()}}DtoTo{{featureName.pascalCase()}}Mapper {
  {{featureName.pascalCase()}} call({{featureName.pascalCase()}}Dto dto) => {{featureName.pascalCase()}}();
}
