part of 'post_details_cubit.dart';

@freezed
abstract class PostDetailsState with _$PostDetailsState {
  const factory PostDetailsState({
    required bool isLoading,
    required Option<Either<Failure, DetailedPost>> isFailureOrDetailedPost,
    required String parentPostId,
    required bool commentingEnabled
  }) = _PostDetailsState;

  const PostDetailsState._();

  factory PostDetailsState.initial({
    required String parentPostId,
    required bool commentingEnabled,
  }) =>
      PostDetailsState(
        parentPostId: parentPostId,
        isLoading: true,
        isFailureOrDetailedPost: none(),
        commentingEnabled: commentingEnabled,
      );
}