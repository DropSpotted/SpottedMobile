import 'package:geo/model/geo_location_permission.dart';
import 'package:geo/model/geo_position.dart';
import 'package:geo/service/geo_impl.dart';

abstract class Geo {
  static Geo create() {
    return GeoImpl();
  }

  Future<bool> isLocationEnabled();

  Future<GeoLocationPermission> requestPermission();

  Future<GeoLocationPermission> checkPermission();

  Future<GeoPosition> getCurrentPosition();

  Future<bool> openAppSettings();

  Future<bool> openLocationSettings();

  Future<GeoPosition?> getLastKnownPosition();
}
