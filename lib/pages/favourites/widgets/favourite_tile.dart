import 'dart:io';
import 'dart:typed_data';

import 'package:domain/model/favourite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spotted/application/application_export.dart';
import 'package:foundation/dates.dart';

class FavouriteTile extends StatelessWidget {
  const FavouriteTile({Key? key, required this.favourite, this.onTap}) : super(key: key);

  final Favourite favourite;
  final VoidCallback? onTap;

  static const double _colorOpacity = 0.12;
  static const double _buttonRadius = 12;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colorful.white,
      borderRadius: BorderRadius.circular(16),
      child: InkResponse(
        containedInkWell: false,
        onTap: onTap,
        highlightColor: Colorful.gray6.withOpacity(_colorOpacity),
        highlightShape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(_buttonRadius),
        splashColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(Insets.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                favourite.place,
                style: context.textThemes.buttonMedium,
              ),
              const SizedBox(height: Insets.small),
              Text(
                favourite.createdAt.toTimaAgo,
                style: context.textThemes.caption?.copyWith(color: Colorful.gray8),
              ),
              const SizedBox(height: Insets.large),
              if (Platform.isAndroid)
                GoogleMapImage(
                  lat: favourite.geoLocationCoords.coordinates.first,
                  lon: favourite.geoLocationCoords.coordinates.last,
                ),
              if (Platform.isIOS)
                AppleMapImage(
                  byteImage: favourite.iOSImage,
                )
            ],
          ),
        ),
      ),
    );
  }
}

class GoogleMapImage extends StatelessWidget {
  const GoogleMapImage({
    Key? key,
    required this.lat,
    required this.lon,
  }) : super(key: key);

  final double lat;
  final double lon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(lat, lon),
            zoom: 14.4746,
          ),
          liteModeEnabled: true,
        ),
      ),
    );
  }
}

class AppleMapImage extends StatelessWidget {
  const AppleMapImage({
    Key? key,
    this.byteImage,
  }) : super(key: key);

  final Uint8List? byteImage;

  @override
  Widget build(BuildContext context) {
    if (byteImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Image.memory(byteImage!),
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: 2 / 1,
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.black),
        ),
      );
    }
  }
}
