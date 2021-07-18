import 'package:geocoding/geocoding.dart';

class Place {
  Place({
    this.name,
    this.street,
    this.isoCountryCode,
    this.country,
    this.postalCode,
    this.administrativeArea,
    this.subAdministrativeArea,
    this.locality,
    this.subLocality,
    this.thoroughfare,
    this.subThoroughfare,
  });

  /// The name associated with the placemark.
  final String? name;

  /// The street associated with the placemark.
  final String? street;

  /// The abbreviated country name, according to the two letter (alpha-2) [ISO standard](https://www.iso.org/iso-3166-country-codes.html).
  final String? isoCountryCode;

  /// The name of the country associated with the placemark.
  final String? country;

  /// The postal code associated with the placemark.
  final String? postalCode;

  /// The name of the state or province associated with the placemark.
  final String? administrativeArea;

  /// Additional administrative area information for the placemark.
  final String? subAdministrativeArea;

  /// The name of the city associated with the placemark.
  final String? locality;

  /// Additional city-level information for the placemark.
  final String? subLocality;

  /// The street address associated with the placemark.
  final String? thoroughfare;

  /// Additional street address information for the placemark.
  final String? subThoroughfare;
}

extension PlaceExtension on Placemark {
  Place toGeo() {
    return Place(
      name: name,
      street: street,
      isoCountryCode: isoCountryCode,
      country: country,
      postalCode: postalCode,
      administrativeArea: administrativeArea,
      subAdministrativeArea: subAdministrativeArea,
      locality: locality,
      subLocality: subLocality,
      thoroughfare: thoroughfare,
      subThoroughfare: subThoroughfare,
    );
  }
}
