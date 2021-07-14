import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_logger_user_error.freezed.dart';

@freezed
class UpdateLoggedUserError with _$UpdateLoggedUserError {
  factory UpdateLoggedUserError({
    List<String>? username,
    List<String>? biographicEntry,
    List<String>? isUserSavedNickname,
  }) = _UpdateLoggedUserError;
}
