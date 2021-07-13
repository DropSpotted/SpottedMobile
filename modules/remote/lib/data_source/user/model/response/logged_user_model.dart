import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/logged_user.dart';

part 'logged_user_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class LoggedUserModel {
  const LoggedUserModel({
    required this.id,
    required this.dateCreated,
    required this.username,
    required this.isUserSavedNickname,
    required this.biographicEntry,
  });

  factory LoggedUserModel.fromJson(Map<String, dynamic> json) => _$LoggedUserModelFromJson(json);

  final String id;
  final String dateCreated;
  final String username;
  final bool isUserSavedNickname;
  final String biographicEntry;

  Map<String, dynamic> toJson() => _$LoggedUserModelToJson(this);
}

extension LoggedUserModelExtenstion on LoggedUserModel {
  LoggedUser toDomain() {
    return LoggedUser(
      id: id,
      dateCreated: DateTime.parse(dateCreated),
      username: username,
      isUserSavedNickname: isUserSavedNickname,
      biographicEntry: biographicEntry,
    );
  }
}
