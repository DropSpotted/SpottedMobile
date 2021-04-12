import 'package:dartz/dartz.dart';
import 'package:domain/data_source/post_remote_data_source.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/detailed_post.dart';
import 'package:domain/model/post.dart';
import 'package:domain/model/post_creation.dart';

abstract class PostService {
  Future<Either<Failure, List<Post>>> postList(double lat, double lon);

  Future<Either<Failure, Unit>> createPost(PostCreation postCreatio);

  Future<Either<Failure, DetailedPost>> detailedPost(String postId);
}

class PostServiceImpl implements PostService {
  PostServiceImpl({
    required PostRemoteDataSource postDataSource,
  }) : _postDataSource = postDataSource;

  final PostRemoteDataSource _postDataSource;

  @override
  Future<Either<Failure, List<Post>>> postList(double lat, double lon) async {
    return _postDataSource.postList(lat, lon);
  }

  @override
  Future<Either<Failure, Unit>> createPost(PostCreation postCreation) async {
    return _postDataSource.createPost(postCreation);
  }

  @override
  Future<Either<Failure, DetailedPost>> detailedPost(String postId) async {
    return _postDataSource.detailedPost(postId);
  }
}
