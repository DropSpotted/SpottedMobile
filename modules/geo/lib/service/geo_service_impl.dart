import 'package:dartz/dartz.dart';
import 'package:geo/error/error_code.dart';
import 'package:geo/model/geo_location_permission.dart';
import 'package:geo/model/geo_position.dart';
import 'package:geo/model/place.dart';
import 'package:geo/service/geo.dart';
import 'package:geo/service/geo_service.dart';

class GeoServiceImpl implements GeoService {
  GeoServiceImpl({
    required Geo geo,
  }) : _geo = geo;

  final Geo _geo;

  @override
  Future<Either<GeoErrorCode, GeoPosition>> currentPosition() async {
    final isEnabled = await _geo.isLocationEnabled();
    if (!isEnabled) {
      return left(
        GeoErrorCode.geoLocationDisabled,
      );
    }

    var permission = await _geo.checkPermission();
    if (permission == GeoLocationPermission.denied) {
      permission = await _geo.requestPermission();
      if (permission == GeoLocationPermission.deniedForever) {
        return left(
          GeoErrorCode.deniedForever,
        );
      }

      if (permission == GeoLocationPermission.denied) {
        return left(
          GeoErrorCode.denied,
        );
      }
    } else if (permission == GeoLocationPermission.deniedForever) {
      return left(
        GeoErrorCode.deniedForever,
      );
    }

    final currentPosition = await _geo.getCurrentPosition();

    return right(currentPosition);
  }

  @override
  Future<bool> openAppSettings() async {
    return _geo.openAppSettings();
  }

  @override
  Future<bool> openLocationSettings() async {
    return _geo.openLocationSettings();
  }

  @override
  Future<List<Place>> placeFromCoordinates({required double lat, required double lon, String? localeIdentifier}) async {
    return (await _geo.placeFromCoordinates(lat: lat, lon: lon, localeIdentifier: localeIdentifier))
        .map((place) => place.toGeo())
        .toList();
  }
}
