import 'package:domain/failure/failure.dart';
import 'package:dio/src/dio_error.dart';
import 'package:domain/model/error/update_logger_user_error.dart';
import 'package:remote/data_source/user/model/error/update_logged_user_error_model.dart';
import 'package:remote/data_source/user/user_remote_data_source_impl.dart';
import 'package:domain/failure/error_body.dart';

extension UserFilureMapper on UserRemoteDataSourceImpl {
  Failure<T> mapDioFailure<T>(DioError dioError) {
    if (dioError.type == DioErrorType.response) {
      try {
        if (T == UpdateLoggedUserError) {
          return Failure.errorBody(
            ErrorBody(data: UpdateLoggedUserErrorModel.fromJson(dioError.response?.data) as T),
          );
        } else {
          return const Failure.defaultType();
        }
      } catch (e) {
        return const Failure.defaultType(); //TODO: map here api errors to errorBody
      }
    } else {
      switch (dioError.type) {
        case DioErrorType.connectTimeout:
          return const Failure.connectTimeout();
        case DioErrorType.sendTimeout:
          return const Failure.sendTimeout();
        case DioErrorType.receiveTimeout:
          return const Failure.receiveTimeout();
        case DioErrorType.cancel:
          return const Failure.cancel();
        default:
          return const Failure.defaultType();
      }
    }
  }
}
