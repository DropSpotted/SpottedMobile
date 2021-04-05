import 'package:dio/dio.dart' hide Headers;
import 'package:remote/data_source/post/model/request/create_post_model.dart';
import 'package:remote/data_source/post/model/response/post_model.dart';

import 'package:retrofit/retrofit.dart';

part 'post_rest_api.g.dart';

@RestApi()
abstract class PostRestApi {
  factory PostRestApi(Dio dio) = _PostRestApi;

  @POST('/api/v1/posts')
  Future<void> createPost(@Body() CreatePostModel registerUserRemoteModel);

  @GET('/api/v1/posts')
  Future<List<PostModel>> getPostList(@Query("lat") double lat, @Query("lon") double lon);
}
