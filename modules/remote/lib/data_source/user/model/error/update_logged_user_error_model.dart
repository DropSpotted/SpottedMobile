import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/error/update_logger_user_error.dart';

part 'update_logged_user_error_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class UpdateLoggedUserErrorModel {
  const UpdateLoggedUserErrorModel({
    this.username,
    this.biographicEntry,
    this.isUserSavedNickname,
  });

  factory UpdateLoggedUserErrorModel.fromJson(Map<String, dynamic> json) => _$UpdateLoggedUserErrorModelFromJson(json);

  final List<String>? username;
  final List<String>? biographicEntry;
  final List<String>? isUserSavedNickname;
}

extension UpdateLoggedUserExtension on UpdateLoggedUserErrorModel {
  UpdateLoggedUserError toDomain() {
    return UpdateLoggedUserError(
      username: username,
      biographicEntry: biographicEntry,
      isUserSavedNickname: isUserSavedNickname,
    );
  }
}