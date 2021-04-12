import 'package:json_annotation/json_annotation.dart';
import 'package:remote/data_source/comment/model/response/comment_model.dart';
import 'package:domain/model/detailed_post.dart';

part 'detailed_post_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class DetailedPostModel {
  const DetailedPostModel({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.modifiedAt,
    required this.geoLocationCoords,
    required this.comments,
  });

  factory DetailedPostModel.fromJson(Map<String, dynamic> json) => _$DetailedPostModelFromJson(json);

  final String id;
  final String body;
  final String createdAt;
  final String modifiedAt;
  final String geoLocationCoords;
  final List<CommentModel> comments;

  Map<String, dynamic> toJson() => _$DetailedPostModelToJson(this);
}

extension DetailedPostModelExtenstion on DetailedPostModel {
  DetailedPost toDomain() {
    final domainComments = comments.map((comment) => comment.toDomain()).toList();

    return DetailedPost(
      id: id,
      body: body,
      createdAt: DateTime.parse(createdAt),
      modifiedAt: DateTime.parse(modifiedAt),
      comments: domainComments,
    );
  }
}
