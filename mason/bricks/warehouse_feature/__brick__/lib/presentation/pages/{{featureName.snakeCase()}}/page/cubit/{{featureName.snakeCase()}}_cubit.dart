import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/domain/usecase/get_{{featureName.snakeCase()}}_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/page/cubit/{{featureName.snakeCase()}}_state.dart';

@injectable
class {{featureName.pascalCase()}}Cubit extends Cubit<{{featureName.pascalCase()}}State> {
  {{featureName.pascalCase()}}Cubit({
    required Get{{featureName.pascalCase()}}DataUseCase get{{featureName.pascalCase()}}DataUseCase,
  }) :  _get{{featureName.pascalCase()}}DataUseCase = get{{featureName.pascalCase()}}DataUseCase,
        super(const {{featureName.pascalCase()}}State.loading());

  final Get{{featureName.pascalCase()}}DataUseCase _get{{featureName.pascalCase()}}DataUseCase;

  Future<void> init() async => (await _get{{featureName.pascalCase()}}DataUseCase()).fold(
        (data) => emit({{featureName.pascalCase()}}State.loaded(model: data)),
        (error) => emit({{featureName.pascalCase()}}State.error(error)),
      );
}
