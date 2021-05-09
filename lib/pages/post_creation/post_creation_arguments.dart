import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spotted/pages/post_creation/bloc/post_creation_bloc.dart';

part 'post_creation_arguments.freezed.dart';

@freezed
abstract class PostCreationArguments with _$PostCreationArguments {
  factory PostCreationArguments({
    required CreationType creationType,
    String? parentPostId,
    Function()? onSuccess,
  }) = _PostCreationArguments;

  factory PostCreationArguments.post({
    required Function()? onSuccess,
  }) {
    return PostCreationArguments(
      creationType: CreationType.post,
      onSuccess: onSuccess,
    );
  }

  factory PostCreationArguments.comment({
    required String? parentPostId,
    required Function()? onSuccess,
  }) {
    return PostCreationArguments(
      creationType: CreationType.comment,
      onSuccess: onSuccess,
      parentPostId: parentPostId,
    );
  }
}
