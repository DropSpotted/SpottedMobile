import 'package:dartz/dartz.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/detailed_post.dart';
import 'package:domain/model/post.dart';
import 'package:domain/model/post_creation.dart';

abstract class PostRemoteDataSource {
  Future<Either<Failure, List<Post>>> postList(double lat, double lon);
  Future<Either<Failure, Unit>> createPost(PostCreation postCreation);
  Future<Either<Failure, DetailedPost>> detailedPost(String id);
}
