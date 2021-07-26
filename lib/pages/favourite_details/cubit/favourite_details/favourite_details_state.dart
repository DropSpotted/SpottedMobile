part of 'favourite_details_cubit.dart';

@freezed
abstract class FavouriteDetailsState with _$FavouriteDetailsState {
  factory FavouriteDetailsState({
    required Favourite favourite,
    required bool isLoadingPosts,
    required Option<Either<Failure, List<Post>>> isFailureOrPosts,
    required Option<Either<Failure, Unit>> isFailureOrRemoved,
    required Option<Either<Failure, Unit>> isFailureOrRenamed,
  }) = _FavouriteDetailsState;

  const FavouriteDetailsState._();

  factory FavouriteDetailsState.initial(Favourite favourite) => FavouriteDetailsState(
        favourite: favourite,
        isLoadingPosts: false,
        isFailureOrPosts: none(),
        isFailureOrRemoved: none(),
        isFailureOrRenamed: none(),
      );
}
