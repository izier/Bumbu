import 'package:dio/dio.dart';

import '../../utils/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (Logger.enabled) {
      Logger.log('REQUEST[${options.method}] => PATH: ${options.path}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (Logger.enabled) {
      Logger.log(
        'RESPONSE[${response.statusCode}] => '
        'PATH: ${response.requestOptions.path}',
      );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (Logger.enabled) {
      Logger.error(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
        err,
        err.stackTrace,
      );
    }
    super.onError(err, handler);
  }
}
