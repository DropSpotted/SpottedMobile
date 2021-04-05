part of 'geo_manager_bloc.dart';

@freezed
class GeoManagerEvent with _$GeoManagerEvent {
  const factory GeoManagerEvent.currentLocationAsked() = _CurrentLocationAsked;
}