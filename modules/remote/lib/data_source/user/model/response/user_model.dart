import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/user.dart';

part 'user_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class UserModel {
  const UserModel({
    required this.id,
    required this.username,
    required this.dateCreated,
    required this.biographicEntry,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  final String id;
  final String username;
  final String dateCreated;
  final String biographicEntry;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

extension UserModelExtenstion on UserModel {
  User toDomain() {
    return User(
      id: id,
      username: username,
      biographicEntry: biographicEntry,
      dateCreated: DateTime.parse(dateCreated),
    );
  }
}
