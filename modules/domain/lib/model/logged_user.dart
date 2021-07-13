import 'package:freezed_annotation/freezed_annotation.dart';

part 'logged_user.freezed.dart';

@freezed
abstract class LoggedUser with _$LoggedUser {
  factory LoggedUser({
    required String id,
    required DateTime dateCreated,
    required String username,
    required bool isUserSavedNickname,
    required String biographicEntry,
  }) = _LoggedUser;
}
