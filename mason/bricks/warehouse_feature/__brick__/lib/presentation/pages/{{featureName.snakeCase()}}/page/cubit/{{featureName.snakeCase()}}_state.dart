import 'package:flu_warehouse_mobile/app/networking/failure.dart';
import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/domain/model/{{featureName.snakeCase()}}.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{featureName.snakeCase()}}_state.freezed.dart';

@freezed
class {{featureName.pascalCase()}}State with _${{featureName.pascalCase()}}State {
  const factory {{featureName.pascalCase()}}State.loading() = {{featureName.pascalCase()}}StateLoading;

  const factory {{featureName.pascalCase()}}State.loaded({
    required {{featureName.pascalCase()}} model,
  }) = {{featureName.pascalCase()}}StateLoaded;

  const factory {{featureName.pascalCase()}}State.error([Failure? failure]) = {{featureName.pascalCase()}}StateError;
}
