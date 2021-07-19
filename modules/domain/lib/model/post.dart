import 'package:domain/model/point.dart';
import 'package:domain/model/user_shorten.dart';
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
    required bool isAnonymous,
    UserShorten? author,
    // place is should be added from cubit
    @Default('') String place,
  }) = _Post;
}
