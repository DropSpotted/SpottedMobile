import 'package:dio/dio.dart' hide Headers;
import 'package:remote/data_source/post/model/request/create_comment_model.dart';

import 'package:retrofit/retrofit.dart';

part 'comment_rest_api.g.dart';

@RestApi()
abstract class CommentRestApi {
  factory CommentRestApi(Dio dio) = _CommentRestApi;

  @GET('/api/v1/comments')
  Future<void> createComment(@Body() CreateCommentModel createCommentModel);
}
