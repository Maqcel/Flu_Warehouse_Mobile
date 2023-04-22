import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flu_warehouse_mobile/di/dependencies.dart';
import 'package:flu_warehouse_mobile/presentation/routing/app_route.dart';
import 'package:flutter/widgets.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function(RootStackRouter appRouter) builder,
) async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) => log(
        details.exceptionAsString(),
        stackTrace: details.stack,
      );

  Bloc.observer = const AppBlocObserver();
  configureDependencies();

  await runZonedGuarded(
    () async => runApp(await builder(AppRouter())),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
