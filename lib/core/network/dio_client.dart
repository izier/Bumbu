import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class DioClient {
  final Dio dio;

  DioClient({Dio? dio})
      : dio = dio ??
      Dio(
        BaseOptions(
          connectTimeout: ApiConstants.timeout,
          receiveTimeout: ApiConstants.timeout,
        ),
      );
}
