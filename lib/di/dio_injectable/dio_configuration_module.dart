import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

const _timeout = Duration(seconds: 30);

@module
abstract class DioConfigurationModule {
  @singleton
  BaseOptions createDioOptions() => BaseOptions(
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
        sendTimeout: _timeout,
        // ignore: avoid_redundant_argument_values
        baseUrl: const String.fromEnvironment('API_URL'),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
}
