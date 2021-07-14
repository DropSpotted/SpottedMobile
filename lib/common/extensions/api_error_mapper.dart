import 'package:domain/failure/error_body.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/error/update_logger_user_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/common/error_message_mapper.dart';

extension ApiErrorMapper on Bloc {
  ErrorMessageCode mapApiError(Failure error) {
    return error.maybeWhen<ErrorMessageCode>(
      errorBody: (body) => ErrorMessageCode.somethingWentWrong,
      unexpected: () => ErrorMessageCode.somethingWentWrong,
      connectTimeout: () => ErrorMessageCode.somethingWentWrong,
      sendTimeout: () => ErrorMessageCode.somethingWentWrong,
      receiveTimeout: () => ErrorMessageCode.somethingWentWrong,
      cancel: () => ErrorMessageCode.somethingWentWrong,
      defaultType: () => ErrorMessageCode.somethingWentWrong,
      orElse: () => ErrorMessageCode.somethingWentWrong,
    );
  }
}

extension FailureMapperExtension on Failure {
  String errorMap(BuildContext context) {
    return map(
      errorBody: (errorBody) => mapErrorBody(errorBody.error),
      unexpected: (state) => 'unexpected',
      connectTimeout: (state) => 'unexpected',
      sendTimeout: (state) => 'unexpected',
      receiveTimeout: (state) => 'unexpected',
      cancel: (state) => 'unexpected',
      defaultType: (state) => 'unexpected',
    );
  }

  String mapErrorBody(ErrorBody errorBody) {
    if(errorBody.data != null) {
      if(errorBody.data is UpdateLoggedUserError) {
        return (errorBody.data as UpdateLoggedUserError).mapError();
      } else {
        return '';
      }
    } else if(errorBody.errorCode != null) {
      return 'xd';
    } else {
      return '';
    }
  }
}

extension UpdateLoggedUserErrorExtension on UpdateLoggedUserError {
  String mapError() {
    if(username != null && username!.isNotEmpty) {
      return username!.first;
    } else if(biographicEntry != null && biographicEntry!.isNotEmpty) {
      return biographicEntry!.first;
    } else if(isUserSavedNickname != null && isUserSavedNickname!.isNotEmpty) {
      return isUserSavedNickname!.first;
    } else {
      return '';
    }
  }
}
