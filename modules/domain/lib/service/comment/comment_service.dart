import 'package:dartz/dartz.dart';
import 'package:domain/data_source/comment_remote_data_source.dart';
import 'package:domain/failure/failure.dart';

abstract class CommentService {
  Future<Either<Failure<dynamic>, Unit>> createComment(String parentId, String commentBody);
}

class CommentServiceImpl implements CommentService {
  CommentServiceImpl({
    required CommentRemoteDataSource commentRemoteDataSource,
  }) : _commentRemoteDataSource = commentRemoteDataSource;

  final CommentRemoteDataSource _commentRemoteDataSource;

  @override
  Future<Either<Failure<dynamic>, Unit>> createComment(String parentId, String commentBody) async {
    return _commentRemoteDataSource.createComment(parentId, commentBody);
  }
}
