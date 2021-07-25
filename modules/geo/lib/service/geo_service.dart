import 'package:dartz/dartz.dart';
import 'package:geo/error/error_code.dart';
import 'package:geo/model/geo_position.dart';
import 'package:geo/model/place.dart';
import 'package:geo/service/geo.dart';
import 'package:geo/service/geo_service_impl.dart';

abstract class GeoService {
  static GeoService create() => GeoServiceImpl(geo: Geo.create());

  Future<Either<GeoErrorCode, GeoPosition>> currentPosition();

  Future<bool> openAppSettings();

  Future<bool> openLocationSettings();

  Future<Either<GeoErrorCode, List<Place>>> placeFromCoordinates({
    required double lat,
    required double lon,
    String? localeIdentifier,
  });
}
