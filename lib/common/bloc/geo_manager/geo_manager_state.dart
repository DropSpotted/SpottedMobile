part of 'geo_manager_cubit.dart';

@freezed
class GeoManagerState with _$GeoManagerState {
  const factory GeoManagerState.initial() = GeoManagerInitial;
  const factory GeoManagerState.load(GeoPosition geoPosition, [@Default(true) bool includeChildLoading]) = GeoManagerLoaded;
  const factory GeoManagerState.failure(GeoErrorCode geoError) = GeoManagerFailure;
}
