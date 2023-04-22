import 'package:auto_route/auto_route.dart';
import 'package:flu_warehouse_mobile/di/dependencies.dart';
import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/presentation/common_widgets/common_loading_widget.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/page/cubit/login_cubit.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/page/cubit/login_state.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/page/view/login_view.dart';
import 'package:flu_warehouse_mobile/presentation/routing/app_route.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginPage extends StatelessWidget
    implements AutoRouteWrapper, ExtensionMixin {
  const LoginPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<LoginCubit>(
        create: (BuildContext context) => getIt<LoginCubit>()..init(),
        child: this,
      );

  @override
  Widget build(BuildContext context) => BlocConsumer<LoginCubit, LoginState>(
        buildWhen: _buildWhen,
        builder: _builder,
        listener: _listener,
      );

  bool _buildWhen(LoginState previous, LoginState current) =>
      current != const LoginState.error() &&
      current != const LoginState.success();

  Widget _builder(BuildContext context, LoginState state) => state.maybeWhen(
        init: () => const Scaffold(body: CommonLoadingWidget()),
        formState: (isLoginInProgress) => LoginView(
          isLoginInProgress: isLoginInProgress,
          onLoginButtonPressed: (login, password) =>
              context.read<LoginCubit>().loginUser(
                    login,
                    password,
                  ),
        ),
        orElse: () => const Scaffold(body: SizedBox.shrink()),
      );

  void _listener(BuildContext context, LoginState state) => state.maybeWhen(
        success: () => AutoRouter.of(context).replaceAll([const HomeRoute()]),
        error: (error) => context.showError(error),
        orElse: () => null,
      );
}
