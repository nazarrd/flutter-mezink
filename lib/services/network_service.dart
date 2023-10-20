import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkService {
  static Dio dio() {
    Dio dio = Dio(BaseOptions(
      baseUrl: 'https://reqres.in/api',
      contentType: Headers.jsonContentType,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ));

    if (!kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        request: false,
        maxWidth: 90,
      ));
    }
    return dio;
  }
}
