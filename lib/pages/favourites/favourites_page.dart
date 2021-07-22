import 'dart:io';
import 'dart:typed_data';

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/pages/favourites/cubit/favourites_cubit.dart';
import 'package:spotted/pages/favourites/widgets/googe_maps.dart';

class FavouritesPage extends StatelessWidget with AutoRouteWrapper {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouritesCubit(
        favouriteService: sl(),
      )..fetchFavourites(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const FavouriteBody(),
    );
  }
}

class FavouriteBody extends StatelessWidget {
  const FavouriteBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FavouritesCubit>().state;

    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return state.isFailureOrSuccess.fold(
        () => const SizedBox(),
        (either) => either.fold(
          (failure) => const Center(
            child: Text('Failed to load favourites'),
          ),
          (result) => ListView.builder(
            itemBuilder: (context, index) {
              if (Platform.isIOS) {
                return MyCont(
                  lat: result[index].geoLocationCoords.coordinates.first,
                  lon: result[index].geoLocationCoords.coordinates.last,
                );
                // return AppleTiles();
              } else if (Platform.isAndroid) {
                return GoogleMaps(
                  lat: result[index].geoLocationCoords.coordinates.first,
                  lon: result[index].geoLocationCoords.coordinates.last,
                );
              } else {
                return SizedBox();
              }
              // return ListTile(
              //   title: Text(result[index].geoLocationCoords.coordinates.first.toString()),
              // );
            },
            itemCount: result.length,
          ),
        ),
      );
    }
  }
}

class MyCont extends StatefulWidget {
  MyCont({
    Key? key,
    required this.lat,
    required this.lon,
  }) : super(key: key);

  final double lat;
  final double lon;

  @override
  _MyContState createState() => _MyContState();
}

class _MyContState extends State<MyCont> {
  static const platform = const MethodChannel('samples.flutter.dev/battery');

  String _batteryLevel = 'Unknown battery level.';
  Uint8List? imageList;

  Future<Uint8List?> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await platform.invokeMethod('getBatteryLevel', {'lat': widget.lat, 'lon': widget.lon});
      batteryLevel = 'Battery level at $result % .';
      setState(() {
        imageList = result;
      });
      return result;
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<Uint8List?>(
            initialData: null,
            future: _getBatteryLevel(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Image.memory(snapshot.data!);
              } else {
                return SizedBox();
              }
            }),
        // if (imageList != null) Image.memory(imageList!),
        // TextButton(
        //   onPressed: () {
        //     _getBatteryLevel();
        //   },
        //   child: Text('dasda'),
        // ),
      ],
    );
  }
}

class AppleTiles extends StatefulWidget {
  AppleTiles({Key? key}) : super(key: key);

  @override
  _AppleTilesState createState() => _AppleTilesState();
}

class _AppleTilesState extends State<AppleTiles> {
  AppleMapController? _mapController;

  CameraPosition _kInitialPosition = CameraPosition(target: LatLng(-33.852, 151.211), zoom: 11.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: AppleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: _kInitialPosition,
      ),
    );
  }

  void onMapCreated(AppleMapController controller) {
    _mapController = controller;
  }
}
