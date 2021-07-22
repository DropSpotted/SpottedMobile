part of 'favourite_details_cubit.dart';

@freezed
abstract class FavouriteDetailsState with _$FavouriteDetailsState {
  factory FavouriteDetailsState({
    required bool isLoadingPosts,
    required Option<Either<Failure, List<Post>>> isFailureOrPosts,
  }) = _FavouriteDetailsState;

  const FavouriteDetailsState._();

  factory FavouriteDetailsState.initial() => FavouriteDetailsState(
        isLoadingPosts: false,
        isFailureOrPosts: none(),
      );

}