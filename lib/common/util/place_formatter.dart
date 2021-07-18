import 'package:geo/model/place.dart';

class PlaceFormatter {
  static String formatToThoroughfareAndSubLocality(Place place) {
    var formattedPlace = '';
    if (place.thoroughfare != null) {
      formattedPlace = '${place.thoroughfare!}, ';
    }
    if (place.subLocality != null) {
      formattedPlace += place.subLocality!;
    }
    return formattedPlace;
  }
}
