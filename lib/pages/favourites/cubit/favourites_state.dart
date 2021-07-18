part of 'favourites_cubit.dart';

@freezed
abstract class FavouritesState with _$FavouritesState {
  const factory FavouritesState({
    required bool isLoading,
    required Option<Either<Failure, List<Favourite>>> isFailureOrSuccess,
  }) = _FavouritesState;

  const FavouritesState._();

  factory FavouritesState.initial() => FavouritesState(
        isLoading: false,
        isFailureOrSuccess: none(),
      );
}
