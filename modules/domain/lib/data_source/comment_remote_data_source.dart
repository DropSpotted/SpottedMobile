import 'package:dartz/dartz.dart';
import 'package:domain/failure/failure.dart';

abstract class CommentRemoteDataSource {
  Future<Either<Failure, Unit>> createComment(String parentId, String commentBody);
}
