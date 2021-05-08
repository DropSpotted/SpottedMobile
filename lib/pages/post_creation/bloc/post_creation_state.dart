part of 'post_creation_bloc.dart';

@freezed
class PostCreationState with _$PostCreationState {
  const factory PostCreationState({
    required PostInput postInput,
    required CreationType creationType,
    required bool isLoading,
    required bool isSuccess,
    String? parentPostId,
  }) = _PostCreationState;

  const PostCreationState._();

  factory PostCreationState.initial({required CreationType creationType, String? parentPostId}) => PostCreationState(
        isLoading: false,
        postInput: const PostInput.pure(),
        isSuccess: false,
        creationType: creationType,
        parentPostId: parentPostId,
      );

  bool get isFormValid => postInput.valid;

  bool get lockSubmitButton => !isFormValid || isLoading;
}

enum CreationType {
  post, comment,
}