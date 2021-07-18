import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:domain/data_source/user_remote_data_source.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/error/update_logger_user_error.dart';
import 'package:domain/model/update_logged_user.dart';
import 'package:domain/model/user.dart';
import 'package:domain/model/logged_user.dart';
import 'package:remote/data_source/user/user_rest_api.dart';
import 'package:remote/data_source/user/user_failure_mapper.dart';
import 'package:remote/data_source/user/model/response/logged_user_model.dart';
import 'package:remote/data_source/user/model/response/user_model.dart';
import 'package:remote/data_source/user/model/request/update_logged_user_model.dart';


class UserRemoteDataSourceImpl implements UserRemoteDateSource {
  UserRemoteDataSourceImpl({required UserRestApi userRestApi}) : _userRestApi = userRestApi;

  final UserRestApi _userRestApi;

  @override
  Future<Either<Failure, User>> getUserById(String userId) async {
    try {
      final user = await _userRestApi.getUserById(userId);
      return right(user.toDomain());
    } on DioError catch (e) {
      return left(mapDioFailure(e));
    }
  }

  @override
  Future<Either<Failure, LoggedUser>> loggedUser() async {
    try {
      final user = await _userRestApi.loggedUser();
      return right(user.toDomain());
    } on DioError catch (e) {
      return left(mapDioFailure(e));
    }
  }

  @override
  Future<Either<Failure<UpdateLoggedUserError>, Unit>> updateUser(UpdateLoggedUser updateLoggedUser) async {
    try {
      await _userRestApi.updateUser(updateLoggedUser.toRemote());
      return right(unit);
    } on DioError catch (e) {
      return left(mapDioFailure<UpdateLoggedUserError>(e));
    }
  }
}
