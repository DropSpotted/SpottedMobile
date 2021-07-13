import 'package:dio/dio.dart';
import 'package:remote/data_source/user/model/request/update_logged_user_model.dart';
import 'package:remote/data_source/user/model/response/logged_user_model.dart';
import 'package:remote/data_source/user/model/response/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'user_rest_api.g.dart';

@RestApi()
abstract class UserRestApi {
  factory UserRestApi(Dio dio) = _UserRestApi;

  @GET('/api/v1/me')
  Future<LoggedUserModel> loggedUser();

  @GET('/api/v1/user/{id}')
  Future<UserModel> getUserById(@Path('id') String userId);

  @PATCH('/api/v1/me/update')
  Future<void> updateUser(@Body() UpdateLoggedUserModel updateLoggedUserModel);
}