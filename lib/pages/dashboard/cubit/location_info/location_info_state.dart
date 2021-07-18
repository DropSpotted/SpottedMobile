part of 'location_info_cubit.dart';

@freezed
abstract class LocationInfoState with _$LocationInfoState {
  const factory LocationInfoState({
    required bool isLoading,
    required Option<Either<GeoErrorCode, List<Place>>> isFailureOrPlaces,
    required RadiusEnum radius,
  }) = _FavoritesCreationState;

  factory LocationInfoState.initial() => LocationInfoState(
        isLoading: true,
        isFailureOrPlaces: none(),
        radius: RadiusEnum.short
      );
}