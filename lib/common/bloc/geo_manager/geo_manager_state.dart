part of 'geo_manager_bloc.dart';

@freezed
class GeoManagerState with _$GeoManagerState {
  const factory GeoManagerState.initial() = _Initial;
  const factory GeoManagerState.load(GeoPosition geoPosition) = _Loaded;
  const factory GeoManagerState.failure(GeoError geoError) = _Failure;
}
