import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/user_shorten.dart';

part 'user_shorten_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class UserShortenModel {
  const UserShortenModel({
    required this.id,
    required this.username,
  });

  factory UserShortenModel.fromJson(Map<String, dynamic> json) => _$UserShortenModelFromJson(json);

  final String id;
  final String username;

  Map<String, dynamic> toJson() => _$UserShortenModelToJson(this);
}

extension UserShortenModelExtenstion on UserShortenModel {
  UserShorten toDomain() {
    return UserShorten(
      id: id,
      username: username,
    );
  }
}
