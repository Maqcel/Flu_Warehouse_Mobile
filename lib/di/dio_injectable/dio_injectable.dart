import 'package:dio/dio.dart';
import 'package:flu_warehouse_mobile/app/networking/interceptors/auth_header_interceptor.dart';
import 'package:flu_warehouse_mobile/app/networking/interceptors/logging_interceptor.dart';
import 'package:flu_warehouse_mobile/di/dependencies.dart';
import 'package:flu_warehouse_mobile/domain/auth/token_store.dart';

import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @singleton
  Dio dio(BaseOptions options) => Dio(options);
}

void registerInterceptors() {
  final dio = getIt<Dio>();
  dio.interceptors.addAll([
    LoggingInterceptor(),
    AuthHeaderInterceptor(tokenStore: getIt<TokenStore>()),
  ]);
}
