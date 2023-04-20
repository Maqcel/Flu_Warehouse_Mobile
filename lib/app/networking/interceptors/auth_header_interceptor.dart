import 'package:dio/dio.dart';
import 'package:flu_warehouse_mobile/domain/auth/token_store.dart';

class AuthHeaderInterceptor extends Interceptor {
  AuthHeaderInterceptor({required TokenStore tokenStore})
      : _tokenStore = tokenStore;

  final TokenStore _tokenStore;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStore.getToken();
    // TODO: Insert proper auth key
    // if (token != null) {
    //   options.headers[KEY] = token;
    // }

    handler.next(options);
  }
}
