import 'package:domain/model/detailed_post.dart';
import 'package:domain/model/post_creation.dart';
import 'package:domain/model/post.dart';
import 'package:dartz/dartz.dart';
import 'package:remote/data_source/post/model/request/create_post_model.dart';
import 'package:remote/data_source/post/model/response/detailed_post_model.dart';
import 'package:remote/data_source/post/post_rest_api.dart';
import 'package:domain/failure/failure.dart';
import 'package:dio/src/dio_error.dart';
import 'package:domain/data_source/post_remote_data_source.dart';
import 'package:remote/data_source/post/model/response/post_model.dart';
import 'package:remote/data_source/post/post_failure_mapper.dart';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  PostRemoteDataSourceImpl({required PostRestApi postRestApi}) : _postRestApi = postRestApi;

  final PostRestApi _postRestApi;

  @override
  Future<Either<Failure, Unit>> createPost(PostCreation postCreation) async {
    try {
      await _postRestApi.createPost(postCreation.toRemote());
      return right(unit);
    } on DioError catch (e) {
      return left(mapDioFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> postList(double lat, double lon, {double radius=4000}) async {
    try {
      final postModelList = await _postRestApi.getPostList(lat, lon, radius);
      final postList = postModelList.map((post) => post.toDomain()).toList();
      return right(postList);
    } on DioError catch (e) {
      return left(mapDioFailure(e));
    }
  }

  @override
  Future<Either<Failure, DetailedPost>> detailedPost(String id) async {
    try {
      final detailedPost = await _postRestApi.getPostById(id);
      return right(detailedPost.toDomain());
    } on DioError catch (e) {
      return left(mapDioFailure(e));
    }
  }
}
