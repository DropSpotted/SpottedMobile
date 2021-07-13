import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:remote/auth_token_provider.dart';
import 'package:remote/auth_stream_provider.dart';

class DioProvider {
  static String dioAuth = 'DioAuth';
  static String dioNoAuth = 'DioNoAuth';

  static Dio create({
    required AuthTokenProvider authTokenProvider,
    required String baseUrl,
    required bool addAuthorizationInterceptor,
    required PrettyDioLogger logger,
    required AuthStreamProvider authStreamProvider,
  }) {
    final dio = Dio()
      ..options.baseUrl = baseUrl
      ..options.responseType = ResponseType.json;

    if (addAuthorizationInterceptor) {
      dio.interceptors.add(_authorizationInterceptor(authTokenProvider, authStreamProvider));
    }

    if (!kReleaseMode) {
      dio.interceptors.add(logger);
    }

    return dio;
  }

  static InterceptorsWrapper _authorizationInterceptor(
      AuthTokenProvider authTokenProvider, AuthStreamProvider authStreamProvider) {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await authTokenProvider.token;
        if (token.isNotEmpty) {
          options.headers.addAll(
            {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          );
        }
        return handler.next(options);
      },
      onResponse: (response, responseInterceptorHandler) {
        authStreamProvider.authenticated();
        return responseInterceptorHandler.next(response);
      },
      onError: (error, errorInterceptionHandler) {
        if (error.response?.statusCode == 401 || error.response?.statusCode == 403) {
          authStreamProvider.unauthenticated();
        } else {
          authStreamProvider.authenticated();
        }
        return errorInterceptionHandler.next(error);
      },
    );
  }
}
