part of 'post_details_cubit.dart';

@freezed
abstract class PostDetailsState with _$PostDetailsState {
  const factory PostDetailsState({
    required bool isLoading,
    required Option<Either<Failure, DetailedPost>> isFailureOrDetailedPost,
    // DetailedPost? detailedPost,
    // required Either<Unit, bool> isFailureOrLoading,
    // required Option<Either<Unit, DetailedPost>> isFailureOrDetailedPost,
    required String parentPostId,
  }) = _PostDetailsState;

  const PostDetailsState._();

  factory PostDetailsState.initial({
    required String parentPostId,
  }) =>
      PostDetailsState(
        parentPostId: parentPostId,
        isLoading: true,
        isFailureOrDetailedPost: none(),
      );
}
