import 'package:domain/model/point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

@freezed
abstract class Post with _$Post {
   factory Post({
    required String id,
    required String body,
    required DateTime createdAt,
    required DateTime modifiedAt,
    required Point geoLocationCoords,
    required int commentsCount,
    // place is should be added from cubit
    @Default('') String place,
  }) = _Post;
}
