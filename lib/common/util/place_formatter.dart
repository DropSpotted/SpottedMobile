import 'package:geo/model/place.dart';

class PlaceFormatter {
  static String formatToThoroughfareAndSubLocality(Place place) {
    var formattedPlace = '';
    if (place.thoroughfare != null && place.thoroughfare!.isNotEmpty) {
      formattedPlace = '${place.thoroughfare!}, ';
    }
    if (place.subLocality != null) {
      formattedPlace += place.subLocality!;
    }
    return formattedPlace;
  }

  static String formatToFullAddress(Place place) {
    var formattedPlace = '';

    if (place.thoroughfare != null && place.thoroughfare!.isNotEmpty) {
      formattedPlace += '${place.thoroughfare!}, ';
    }
    if (place.subLocality != null && place.subLocality!.isNotEmpty) {
      formattedPlace += '${place.subLocality!}, ';
    }
    if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
      formattedPlace += '${place.administrativeArea!}, ';
    }
    if (place.country != null && place.country!.isNotEmpty) {
      formattedPlace += place.country!;
    }

    return formattedPlace;
  }
}
