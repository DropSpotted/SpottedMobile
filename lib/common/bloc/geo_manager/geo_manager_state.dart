part of 'geo_manager_bloc.dart';

@freezed
class GeoManagerState with _$GeoManagerState {
  const factory GeoManagerState.initial() = _Initial;
  const factory GeoManagerState.load(GeoPosition geoPosition, [@Default(true) bool includeChildLoading]) = _Loaded;
  const factory GeoManagerState.failure(GeoErrorCode geoError) = _Failure;
}
