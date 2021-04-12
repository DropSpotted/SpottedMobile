import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/comment.dart';

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
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  final String id;
  final String body;
  final String createdAt;
  final String modifiedAt;
  final String parent;

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
    );
  }
}