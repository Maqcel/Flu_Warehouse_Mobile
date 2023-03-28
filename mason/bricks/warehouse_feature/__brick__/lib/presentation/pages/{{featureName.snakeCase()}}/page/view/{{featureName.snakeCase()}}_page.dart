import 'package:auto_route/auto_route.dart';
import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/swimexpress_loading.dart';
import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/page/cubit/{{featureName.snakeCase()}}_cubit.dart';
import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/page/cubit/{{featureName.snakeCase()}}_state.dart';
import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/page/view/{{featureName.snakeCase()}}_view.dart';
import 'package:flu_warehouse_mobile/di/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class {{featureName.pascalCase()}}Page extends StatelessWidget implements AutoRouteWrapper, ExtensionMixin {
  const {{featureName.pascalCase()}}Page({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<{{featureName.pascalCase()}}Cubit>(
        create: (BuildContext context) => getIt<{{featureName.pascalCase()}}Cubit>()..init(),
        child: this,
      );

  @override
  Widget build(BuildContext context) => BlocConsumer<{{featureName.pascalCase()}}Cubit, {{featureName.pascalCase()}}State>(
        buildWhen: _buildWhen,
        builder: _builder,
        listener: _listener,
      );

  bool _buildWhen({{featureName.pascalCase()}}State previous, {{featureName.pascalCase()}}State current) => 
      current != const {{featureName.pascalCase()}}State.error();

  Widget _builder(BuildContext context, {{featureName.pascalCase()}}State state) => state.maybeWhen(
        loading: _loadingBody,
        loaded: (model) => _buildBody(context),
        orElse: () => const SizedBox.shrink(),
      );

  Widget _loadingBody() => const Scaffold(
        body: Center(child: SwimExpressLoadingWidget(),),
      );

  Widget _buildBody(BuildContext context) => const {{featureName.pascalCase()}}View();

  void _listener(BuildContext context, {{featureName.pascalCase()}}State state) =>
    state.maybeWhen(
      error: (error) => context.showError(error!),
      orElse: () => null,
    );
}
