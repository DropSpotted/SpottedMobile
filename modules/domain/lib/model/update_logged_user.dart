import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_logged_user.freezed.dart';

@freezed
abstract class UpdateLoggedUser with _$UpdateLoggedUser {
  factory UpdateLoggedUser({
    String? username,
    String? biographicEntry,
    bool? isUserSavedNickname,
  }) = _UpdateLoggedUser;
}
