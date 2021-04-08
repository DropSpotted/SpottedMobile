part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.started(double lat, double lon, [@Default(true) bool includeLoading]) = _Started;
}