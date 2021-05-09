import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_creation.freezed.dart';

@freezed
class CommentCreation with _$CommentCreation {
   factory CommentCreation({
    required String body,
    required double lat,
    required double lon,
  }) = _CommentCreation;
}
