import 'package:domain/model/user_shorten.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';

@freezed
abstract class Comment with _$Comment {
  factory Comment({
    required String id,
    required String body,
    required DateTime createdAt,
    required DateTime modifiedAt,
    required String parent,
    required UserShorten user,
  }) = _Comment;
}
