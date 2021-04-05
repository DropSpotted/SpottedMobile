import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_creation.freezed.dart';

@freezed
abstract class PostCreation with _$PostCreation {
   factory PostCreation({
    required String body,
    required double lat,
    required double lon,
  }) = _PostCreation;
}
