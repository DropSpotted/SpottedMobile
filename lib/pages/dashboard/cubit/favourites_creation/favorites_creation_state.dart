part of 'favorites_creation_cubit.dart';

@freezed
abstract class FavoritesCreationState with _$FavoritesCreationState {
  const factory FavoritesCreationState({
    required bool isLoadingFavourite,
    // add to posts when new page
    required Option<Either<Failure, Unit>> isFailureOrSuccessFavouriteCreate,
    required Option<GeoErrorCode> geoErrorCode,
  }) = _FavoritesCreationState;

  const FavoritesCreationState._();

  factory FavoritesCreationState.initial() => FavoritesCreationState(
        isLoadingFavourite: false,
        isFailureOrSuccessFavouriteCreate: none(),
        geoErrorCode: none(),
      );
}
