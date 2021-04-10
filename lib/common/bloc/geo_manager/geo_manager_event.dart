part of 'geo_manager_bloc.dart';

@freezed
class GeoManagerEvent with _$GeoManagerEvent {
  const factory GeoManagerEvent.currentLocationAsked([@Default(true) bool includeChildLoading]) = _CurrentLocationAsked;

  const factory GeoManagerEvent.settingsOpened() = _SettingsOpened;

  const factory GeoManagerEvent.locationOpened() = _LocationOpened;
}
