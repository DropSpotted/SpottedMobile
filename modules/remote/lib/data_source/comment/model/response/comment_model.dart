import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/comment.dart';
import 'package:remote/data_source/post/model/response/user_shorten_model.dart';

part 'comment_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class CommentModel {
  const CommentModel({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.modifiedAt,
    required this.parent,
    required this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  final String id;
  final String body;
  final String createdAt;
  final String modifiedAt;
  final String parent;
  final UserShortenModel user;

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}

extension CommentModelExtenstion on CommentModel {
  Comment toDomain() {
    return Comment(
      id: id,
      body: body,
      createdAt: DateTime.parse(createdAt),
      modifiedAt: DateTime.parse(modifiedAt),
      parent: parent,
      user: user.toDomain(),
    );
  }
}
