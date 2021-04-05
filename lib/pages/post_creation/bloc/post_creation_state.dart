part of 'post_creation_bloc.dart';

@freezed
class PostCreationState with _$PostCreationState {
  const factory PostCreationState({
    required PostInput postInput,
    required bool isLoading,
    required bool isSuccess,
  }) = _PostCreationState;

  const PostCreationState._();

  factory PostCreationState.initial() => PostCreationState(
        isLoading: false,
        postInput: PostInput.pure(),
        isSuccess: false,
      );

  bool get isFormValid => postInput.valid;

  bool get lockSubmitButton => !isFormValid || isLoading;
}
