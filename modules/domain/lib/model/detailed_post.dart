import 'package:domain/model/comment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detailed_post.freezed.dart';

@freezed
abstract class DetailedPost with _$DetailedPost {
   factory DetailedPost({
    required String id,
    required String body,
    required DateTime createdAt,
    required DateTime modifiedAt,
    required List<Comment> comments,
  }) = _DetailedPost;
}
