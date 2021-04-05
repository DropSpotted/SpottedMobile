import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioProvider {
  static String dioAuth = 'DioAuth';
  static String dioNoAuth = 'DioNoAuth';

  static Dio create({
    required String baseUrl,
    required bool addAuthorizationInterceptor,
    required PrettyDioLogger logger,
  }) {
    final dio = Dio()
      ..options.baseUrl = baseUrl
      ..options.responseType = ResponseType.json;

    if (!kReleaseMode) {
      dio.interceptors.add(logger);
    }

    return dio;
  }
}
