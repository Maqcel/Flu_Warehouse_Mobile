import 'package:dio/dio.dart';
import 'package:fimber_io/fimber_io.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  static final _logSplitRegExp = RegExp(
    '.{1,850}',
    multiLine: true,
    dotAll: true,
  );

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    Fimber.i(
      [
        'REQUEST[${options.method}] => PATH: ${options.baseUrl}${options.path}',
        'QUERY PARAMS: ${options.queryParameters}',
        'DATA: ${options.data}'
      ].join('\n'),
    );
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final String data = response.data.toString();
    final String requestPath =
        response.requestOptions.baseUrl + response.requestOptions.path;
    Fimber.i(
      [
        'RESPONSE[${response.statusCode}] => PATH: $requestPath',
        'DATA: $data',
      ].join('\n'),
    );
    _logSplitRegExp
        .allMatches(data)
        .forEach((match) => Fimber.i(match.group(0).toString()));
    return super.onResponse(response, handler);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    final String requestPath =
        err.requestOptions.baseUrl + err.requestOptions.path;
    final String responseText = err.response != null
        ? err.response!.data.toString()
        : 'No Error message';
    Fimber.e(
      [
        'ERROR[${err.response?.statusCode}] => PATH: $requestPath',
        'MESSAGE: ${err.message}',
        'RESPONSE: $responseText',
      ].join('\n'),
    );
    return super.onError(err, handler);
  }
}
