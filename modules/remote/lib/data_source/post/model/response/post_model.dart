import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/post.dart';

part 'post_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class PostModel {
  const PostModel({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.modifiedAt,
    required this.geoLocationCoords,
    required this.commentsCount,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  final String id;
  final String body;
  final String createdAt;
  final String modifiedAt;
  final String geoLocationCoords;
  final int commentsCount;

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

extension PostModelExtenstion on PostModel {
  Post toDomain() {
    return Post(
      body: body,
      createdAt: DateTime.parse(createdAt),
      modifiedAt: DateTime.parse(modifiedAt),
      id: id,
      geoLocationCoords: geoLocationCoords,
      commentsCount: commentsCount,
    );
  }
}
