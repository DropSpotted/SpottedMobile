import 'package:dio/dio.dart';
import 'package:domain/data_source/post_remote_data_source.dart';
import 'package:domain/data_source/comment_remote_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:remote/data_source/comment/comment_remote_datasource_impl.dart';
import 'package:remote/data_source/comment/comment_rest_api.dart';
import 'package:remote/data_source/post/post_remote_datasource_impl.dart';
import 'package:remote/data_source/post/post_rest_api.dart';

import 'package:remote/dio_provider.dart';

extension RemoteInjector on GetIt {
  void registerRemote({
    required String baseUrl,
  }) {
    this
      ..registerFactory<PrettyDioLogger>(
        () => PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      )
      ..registerFactory<Dio>(
        () => DioProvider.create(
          baseUrl: baseUrl,
          logger: get<PrettyDioLogger>(),
          addAuthorizationInterceptor: true,
        ),
        instanceName: DioProvider.dioAuth,
      )
      ..registerFactory<Dio>(
        () => DioProvider.create(
          baseUrl: baseUrl,
          logger: get<PrettyDioLogger>(),
          addAuthorizationInterceptor: false,
        ),
        instanceName: DioProvider.dioNoAuth,
      )
      ..registerFactory<PostRemoteDataSource>(
        () => PostRemoteDataSourceImpl(
          postRestApi: get<PostRestApi>(),
        ),
      )
      ..registerFactory<PostRestApi>(
        () => PostRestApi(
          get(instanceName: DioProvider.dioAuth),
        ),
      )
      ..registerFactory<CommentRemoteDataSource>(
        () => CommentRemoteDataSourceImpl(
          commentRestApi: get<CommentRestApi>(),
        ),
      )
      ..registerFactory<CommentRestApi>(
        () => CommentRestApi(
          get(instanceName: DioProvider.dioAuth),
        ),
      );
  }
}
