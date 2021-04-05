import 'package:geolocator/geolocator.dart';

class GeoPosition {
  GeoPosition({
    required this.longitude,
    required this.latitude,
    required this.timestamp,
    required this.accuracy,
    required this.altitude,
    required this.heading,
    required this.speed,
    required this.speedAccuracy,
    this.floor,
    this.isMocked = false,
  });


  final double latitude;
  final double longitude;
  final DateTime? timestamp;
  final double altitude;
  final double accuracy;
  final double heading;
  final int? floor;
  final double speed;
  final double speedAccuracy;
  final bool isMocked;
}

extension PositionExtension on Position {
  GeoPosition toGeo() {
    return GeoPosition(
      latitude: latitude,
      longitude: longitude,
      timestamp: timestamp,
      accuracy: accuracy,
      altitude: altitude,
      heading: heading,
      speed: speed,
      speedAccuracy: speedAccuracy,
      floor: floor,
      isMocked: isMocked
    );
  }
}