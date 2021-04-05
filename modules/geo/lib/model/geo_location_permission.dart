import 'package:geolocator/geolocator.dart';

enum GeoLocationPermission {
  denied,

  deniedForever,

  whileInUse,

  always
}

extension GeoLocationPermissionExtension on LocationPermission {
  GeoLocationPermission toGeo() {
    switch (this) {
      case LocationPermission.denied:
        return GeoLocationPermission.denied;
      case LocationPermission.deniedForever:
        return GeoLocationPermission.deniedForever;
      case LocationPermission.whileInUse:
        return GeoLocationPermission.whileInUse;
      case LocationPermission.always:
        return GeoLocationPermission.always;
    }
  }
}
