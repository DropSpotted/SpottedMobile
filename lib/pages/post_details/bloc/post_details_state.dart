part of 'post_details_bloc.dart';

@freezed
class PostDetailsState with _$PostDetailsState {
  const factory PostDetailsState.inProgress() = _InProgress;
  const factory PostDetailsState.success(DetailedPost detailedPost) = _Success;
  const factory PostDetailsState.failure() = _Failure;
}
