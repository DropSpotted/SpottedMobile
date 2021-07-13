import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/update_logged_user.dart';

part 'update_logged_user_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class UpdateLoggedUserModel {
  const UpdateLoggedUserModel({
    this.username,
    this.biographicEntry,
    this.isUserSavedNickname,
  });

  factory UpdateLoggedUserModel.fromJson(Map<String, dynamic> json) => _$UpdateLoggedUserModelFromJson(json);

  final String? username;
  final String? biographicEntry;
  final bool? isUserSavedNickname;

  Map<String, dynamic> toJson() => _$UpdateLoggedUserModelToJson(this);
}

extension UpdateLoggedUserExtension on UpdateLoggedUser {
  UpdateLoggedUserModel toRemote() {
    return UpdateLoggedUserModel(
      username: username,
      biographicEntry: biographicEntry,
      isUserSavedNickname: isUserSavedNickname,
    );
  }
}