import 'dart:io';

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
                return AppleTiles();
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
