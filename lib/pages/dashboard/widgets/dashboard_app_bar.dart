import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geo/model/place.dart';
import 'package:spotted/pages/dashboard/cubit/dashboard/dashboard_cubit.dart';
import 'package:spotted/pages/dashboard/cubit/favourites_creation/favorites_creation_cubit.dart';
import 'package:spotted/pages/dashboard/cubit/location_info/location_info_cubit.dart';
import 'package:spotted/pages/dashboard/widgets/radius_dialog.dart';
import 'package:spotted/pages/post_creation/post_creation_arguments.dart';
import 'package:spotted/router/app_router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/model/enum/radius_enum.dart';
import 'package:spotted/widgets/buttons/spotted_text_button.dart';

class DashboardAppBar extends StatelessWidget with PreferredSizeWidget {
  const DashboardAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DashboardCubit>().state;
    final favouritesState = context.watch<FavoritesCreationCubit>().state;
    final placesState = context.watch<LocationInfoCubit>().state;

    return AppBar(
      leading: state.showAppbarIcons
          ? favouritesState.isLoadingFavourite
              ? const CircularProgressIndicator()
              : IconButton(
                  onPressed: () => context.read<FavoritesCreationCubit>().createFavourite(),
                  icon: const Icon(Icons.favorite),
                )
          : null,
      title: placesState.isLoading
          ? const SizedBox()
          : placesState.isFailureOrPlaces.fold(
              () => const SizedBox(),
              (either) => either.fold(
                (failure) => const SizedBox(),
                (result) => LocationInfoTitle(
                  places: result,
                  radius: placesState.radius,
                ),
              ),
            ),
      centerTitle: true,
      actions: [
        if (state.showAppbarIcons)
          Center(
            child: IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => context.router.push(
                PostCreationRoute(
                  postCreationArguments: PostCreationArguments.post(
                    onSuccess: () => context.read<DashboardCubit>().fetchPosts(),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class LocationInfoTitle extends StatelessWidget {
  const LocationInfoTitle({
    Key? key,
    required this.places,
    required this.radius,
  }) : super(key: key);

  final List<Place> places;
  final RadiusEnum radius;

  String get _locationInfo {
    switch (radius) {
      case RadiusEnum.short:
        if (places.isNotEmpty || places.first.thoroughfare != null) {
          return places.first.thoroughfare!;
        } else {
          return RadiusEnum.short.toDistance().toString() + 'm';
        }
      case RadiusEnum.medium:
        if (places.isNotEmpty || places.first.subLocality != null) {
          return places.first.subLocality!;
        } else {
          return RadiusEnum.medium.toDistance().toString() + 'm';
        }
      case RadiusEnum.long:
        if (places.isNotEmpty || places.first.locality != null) {
          return places.first.locality!;
        } else {
          return RadiusEnum.long.toDistance().toString() + 'm';
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return const Text('some radius');
    } else {
      return SpottedTextButton(
        maxLines: 1,
        text: _locationInfo,
        onTap: () {
          SpottedRadiusDialog.show(
            context,
            radius: context.read<LocationInfoCubit>().state.radius,
            onSaveChanges: (value) {
              context.read<LocationInfoCubit>().radiusChange(value);
              context.read<DashboardCubit>().fetchPosts(radius: value);
            },
          );
        },
      );
    }
  }
}
