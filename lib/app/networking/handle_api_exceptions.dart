import 'package:dio/dio.dart';
import 'package:flu_warehouse_mobile/app/networking/result.dart';

class HandleApiExceptions {
  static Result<T> handleError<T>(dynamic error) {
    if (error is DioError) {
      return Result<T>.failure(error);
    } else {
      return Result<T>.failure(
        DioError(
          requestOptions: RequestOptions(path: 'Backend error'),
          error: DioErrorType.badResponse,
          response: Response(
            data: {'error': 'Sth went wrong'},
            requestOptions: RequestOptions(path: 'Backend error'),
          ),
        ),
      );
    }
  }
}
