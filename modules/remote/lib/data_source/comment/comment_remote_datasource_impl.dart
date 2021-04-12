import 'package:dartz/dartz.dart';
import 'package:remote/data_source/comment/comment_rest_api.dart';
import 'package:remote/data_source/post/model/request/create_comment_model.dart';
import 'package:domain/failure/failure.dart';
import 'package:dio/src/dio_error.dart';
import 'package:domain/data_source/comment_remote_data_source.dart';
import 'package:remote/data_source/comment/comment_failure_mapper.dart';

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  CommentRemoteDataSourceImpl({required CommentRestApi commentRestApi}) : _commentRestApi = commentRestApi;

  final CommentRestApi _commentRestApi;

  @override
  Future<Either<Failure, Unit>> createComment(String parentId, String commentBody) async {
    try {
      await _commentRestApi.createComment(CreateCommentModel(body: commentBody, parent: parentId));
      return right(unit);
    } on DioError catch (e) {
      return left(mapDioFailure(e));
    }
  }
}
