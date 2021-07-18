import 'package:geo/model/geo_location_permission.dart';
import 'package:geo/model/geo_position.dart';
import 'package:geo/service/geo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoImpl implements Geo {
  @override
  Future<GeoLocationPermission> checkPermission() async {
    return (await Geolocator.checkPermission()).toGeo();
  }

  @override
  Future<GeoPosition> getCurrentPosition() async {
    return (await Geolocator.getCurrentPosition()).toGeo();
  }

  @override
  Future<bool> isLocationEnabled() async {
    return Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<GeoLocationPermission> requestPermission() async {
    return (await Geolocator.requestPermission()).toGeo();
  }

  @override
  Future<bool> openAppSettings() async {
    return Geolocator.openAppSettings();
  }

  @override
  Future<bool> openLocationSettings() async {
    return Geolocator.openLocationSettings();
  }

  @override
  Future<GeoPosition?> getLastKnownPosition() async {
    return (await Geolocator.getLastKnownPosition())?.toGeo();
  }

  @override
  Future<List<Placemark>> placeFromCoordinates({
    required double lat,
    required double lon,
    String? localeIdentifier,
  }) async {
    return placemarkFromCoordinates(lat, lon, localeIdentifier: localeIdentifier);
  }
}
