import 'package:json_annotation/json_annotation.dart';

part 'create_comment_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class CreateCommentModel {
  const CreateCommentModel({
    required this.body,
    required this.parent,
  });

  factory CreateCommentModel.fromJson(Map<String, dynamic> json) => _$CreateCommentModelFromJson(json);

  final String body;
  final String parent;

  Map<String, dynamic> toJson() => _$CreateCommentModelToJson(this);
}
