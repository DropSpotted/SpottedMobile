import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spotted/pages/post_creation/cubit/post_creation_cubit.dart';

part 'post_details_arguments.freezed.dart';

@freezed
abstract class PostDetailsArguments with _$PostDetailsArguments {
  factory PostDetailsArguments({
    required bool commentingEnabled,
    required String postId,
  }) = _PostDetailsArguments;
}
