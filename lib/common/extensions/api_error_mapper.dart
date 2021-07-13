import 'package:domain/failure/failure.dart';
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
