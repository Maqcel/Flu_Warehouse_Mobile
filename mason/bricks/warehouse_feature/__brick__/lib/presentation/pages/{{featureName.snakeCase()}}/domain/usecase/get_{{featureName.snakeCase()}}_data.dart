import 'package:flu_warehouse_mobile/app/networking/result.dart';
import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/domain/model/{{featureName.snakeCase()}}.dart';
import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/domain/service/{{featureName.snakeCase()}}_service.dart';
import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/data/mapper/{{featureName.snakeCase()}}_dto_to_{{featureName.snakeCase()}}_mapper.dart';
import 'package:injectable/injectable.dart';

@injectable
class Get{{featureName.pascalCase()}}DataUseCase {
  Get{{featureName.pascalCase()}}DataUseCase({
    required {{featureName.pascalCase()}}Service {{featureName.camelCase()}}Service,
    required {{featureName.pascalCase()}}DtoTo{{featureName.pascalCase()}}Mapper {{featureName.camelCase()}}Mapper,
  }): _{{featureName.camelCase()}}Service = {{featureName.camelCase()}}Service,
  _{{featureName.camelCase()}}Mapper = {{featureName.camelCase()}}Mapper;

  final {{featureName.pascalCase()}}Service _{{featureName.camelCase()}}Service;
  final {{featureName.pascalCase()}}DtoTo{{featureName.pascalCase()}}Mapper
      _{{featureName.camelCase()}}Mapper;

  Future<Result<{{featureName.pascalCase()}}>> call() async =>
      (await _{{featureName.camelCase()}}Service.get{{featureName.pascalCase()}}Data()).fold(
        (dto) => Result.success(_{{featureName.camelCase()}}Mapper(dto)),
        Result.failure,
      );
}
