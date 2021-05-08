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
}
