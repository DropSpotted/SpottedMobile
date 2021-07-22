import 'dart:io';
import 'dart:typed_data';

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/application/application_export.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/pages/favourites/cubit/favourites_cubit.dart';
import 'package:spotted/pages/favourites/widgets/favourite_tile.dart';
import 'package:spotted/pages/favourites/widgets/googe_maps.dart';
import 'package:spotted/router/app_router.gr.dart';

class FavouritesPage extends StatelessWidget with AutoRouteWrapper {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => FavouritesCubit(
        favouriteService: sl(),
        geoService: sl(),
      )..fetchFavourites(MediaQuery.of(context).size.width),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourites',
          style: context.textThemes.hheadline.copyWith(
            color: Colorful.gray2,
          ),
        ),
      ),
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
          (result) => ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: Insets.small),
            itemBuilder: (context, index) {
              return FavouriteTile(
                favourite: result[index],
                onTap: () => context.router.push(
                  FavouriteDetailsRoute(favourite: result[index]),
                ),
              );
            },
            itemCount: result.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: Insets.large,
            ),
          ),
        ),
      );
    }
  }
}
