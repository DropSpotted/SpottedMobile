part of 'post_details_bloc.dart';

@freezed
class PostDetailsState with _$PostDetailsState {
  const factory PostDetailsState({
    DetailedPost? detailedPost,
    required Either<Unit, bool> isFailureOrLoading,
    // required Option<Either<Unit, DetailedPost>> isFailureOrDetailedPost,
    required String parentPostId,
  }) = _PostDetailsState;

  const PostDetailsState._();

  factory PostDetailsState.initial({
    required String parentPostId,
  }) =>
      PostDetailsState(
        parentPostId: parentPostId,
        detailedPost: null,
        isFailureOrLoading: right(true),
      );

  // const factory PostDetailsState.inProgress() = _InProgress;
  // const factory PostDetailsState.success(DetailedPost detailedPost) = _Success;
  // const factory PostDetailsState.failure() = _Failure;
}
