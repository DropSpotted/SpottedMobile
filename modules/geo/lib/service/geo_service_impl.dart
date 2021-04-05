import 'package:dartz/dartz.dart';
import 'package:geo/error/error_code.dart';
import 'package:geo/error/geo_error.dart';
import 'package:geo/model/geo_location_permission.dart';
import 'package:geo/model/geo_position.dart';
import 'package:geo/service/geo.dart';
import 'package:geo/service/geo_service.dart';

class GeoServiceImpl implements GeoService {
  GeoServiceImpl({
    required Geo geo,
  }) : _geo = geo;

  final Geo _geo;

  @override
  Future<Either<GeoError<PermissionErrorCode>, GeoPosition>> currentPosition() async {
    final isEnabled = await _geo.isLocationEnabled();
    if (!isEnabled) {
      return left(
        GeoError<PermissionErrorCode>(
          code: PermissionErrorCode.geoLocationDisabled,
        ),
      );
    }

    var permission = await _geo.checkPermission();
    if (permission == GeoLocationPermission.denied) {
      permission = await _geo.requestPermission();
      if (permission == GeoLocationPermission.deniedForever) {
        return left(
          GeoError<PermissionErrorCode>(
            code: PermissionErrorCode.deniedForever,
          ),
        );
      }

      if (permission == GeoLocationPermission.denied) {
        return left(
          GeoError<PermissionErrorCode>(
            code: PermissionErrorCode.denied,
          ),
        );
      }
    }
    
    final currentPosition = await _geo.getCurrentPosition();

    return right(currentPosition);
  }
}
