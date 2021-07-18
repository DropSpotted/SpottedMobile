part of 'post_creation_cubit.dart';

@freezed
class PostCreationState with _$PostCreationState {
  const factory PostCreationState({
    required PostInput postInput,
    required CreationType creationType,
    required bool isLoading,
    required Option<Either<Failure, Unit>> failureOrSuccess,
    required Option<GeoErrorCode> geoErrorCode,
    // required bool isSuccess,
    String? parentPostId,
  }) = _PostCreationState;

  const PostCreationState._();

  factory PostCreationState.initial({required CreationType creationType, String? parentPostId}) => PostCreationState(
        isLoading: false,
        postInput: const PostInput.pure(),
        failureOrSuccess: none(),
        creationType: creationType,
        parentPostId: parentPostId,
        geoErrorCode: none(),
      );

  bool get isFormValid => postInput.valid;

  bool get lockSubmitButton => !isFormValid || isLoading;
}

enum CreationType {
  post, comment,
}
