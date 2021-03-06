import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/post.dart';
import 'package:remote/data_source/post/model/response/user_shorten_model.dart';
import 'package:remote/model/point_model.dart';

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
    required this.isAnonymous,
    this.author,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  final String id;
  final String body;
  final String createdAt;
  final String modifiedAt;
  final PointModel geoLocationCoords;
  final UserShortenModel? author;
  final int commentsCount;
  final bool isAnonymous;

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

extension PostModelExtenstion on PostModel {
  Post toDomain() {
    return Post(
      body: body,
      createdAt: DateTime.parse(createdAt),
      modifiedAt: DateTime.parse(modifiedAt),
      id: id,
      geoLocationCoords: geoLocationCoords.toDomain(),
      commentsCount: commentsCount,
      author: author?.toDomain(),
      isAnonymous: isAnonymous
    );
  }
}
