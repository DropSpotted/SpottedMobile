import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/favourite.dart';
import 'package:domain/service/favourite/favourite_service.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geo/model/place.dart';
import 'package:geo/service/geo_service.dart';
import 'package:spotted/common/util/place_formatter.dart';

part 'favourites_state.dart';
part 'favourites_cubit.freezed.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit({
    required FavouriteService favouriteService,
    required GeoService geoService,
    required double imageWidth,
  })  : _favouriteService = favouriteService,
        _geoService = geoService,
        _imageWidth = imageWidth,
        super(FavouritesState.initial());

  final FavouriteService _favouriteService;
  final GeoService _geoService;
  final double _imageWidth;

  static const platform = MethodChannel('samples.flutter.dev/battery');

  Future<void> fetchFavourites() async {
    emit(state.copyWith(isLoading: true, isFailureOrSuccess: none()));
    final favourites = await _favouriteService.favouriteList();
    final newState = await favourites.fold(
      (failure) async => state.copyWith(
        isLoading: false,
        isFailureOrSuccess: optionOf(
          left(failure),
        ),
      ),
      (result) async {
        // var updatedFavourites = result;
        // if (Platform.isIOS) {
        //   updatedFavourites = await Stream.fromIterable(result).asyncMap((fav) async {
        //     final finalResult = await platform.invokeMethod(
        //       'getBatteryLevel',
        //       {
        //         'lat': fav.geoLocationCoords.coordinates.first,
        //         'lon': fav.geoLocationCoords.coordinates.last,
        //         'imgWidth': imageWidth,
        //       },
        //     );

        //     return fav.copyWith(iOSImage: finalResult);
        //   }).toList();
        // }

        // final updatedFavourites2 = await Stream.fromIterable(updatedFavourites).asyncMap((fav) async {
        //   try {
        //     final updateFavourite = await _geoService.placeFromCoordinates(
        //       lat: fav.geoLocationCoords.coordinates.first,
        //       lon: fav.geoLocationCoords.coordinates.last,
        //     );
        //     if (updateFavourite.isNotEmpty) {
        //       return fav.copyWith(
        //         place: PlaceFormatter.formatToFullAddress(updateFavourite.first),
        //       );
        //     } else {
        //       return fav;
        //     }
        //   } catch (e) {
        //     return fav;
        //   }
        // }).toList();

        return state.copyWith(
          isLoading: false,
          isFailureOrSuccess: optionOf(right(result)),
        );
      },
    );

    emit(newState);

    await state.isFailureOrSuccess.fold(() async {}, (either) async {
      await either.fold(
        (failure) async {},
        (result) async {
          for (int i = 0; i < result.length; i++) {
            await emitUpdatedTile(i, result[i]);
          }
        },
      );
    });
  }

  Future<void> emitUpdatedTile(int index, Favourite favourite) async {
    if (Platform.isIOS) {
      final finalResult = await platform.invokeMethod(
        'getBatteryLevel',
        {
          'lat': favourite.geoLocationCoords.coordinates.first,
          'lon': favourite.geoLocationCoords.coordinates.last,
          'imgWidth': 400,
        },
      );

      favourite = favourite.copyWith(iOSImage: finalResult);
    }
    try {
      final updateFavourite = await _geoService.placeFromCoordinates(
        lat: favourite.geoLocationCoords.coordinates.first,
        lon: favourite.geoLocationCoords.coordinates.last,
      );

      final resultPlace = updateFavourite.fold(
        (failure) => <Place>[],
        (result) => result,
      );

      if (resultPlace.isNotEmpty) {
        favourite = favourite.copyWith(
          place: PlaceFormatter.formatToFullAddress(resultPlace.first),
        );
      }
    } catch (e) {
      print(e);
    }

    state.isFailureOrSuccess.fold(() {}, (either) {
      either.fold(
        (failure) {},
        (result) {
          var newList = [...result];

          newList[index] = favourite;

          xd(newList);
        },
      );
    });
  }

  void xd(List<Favourite> vas) {
    emit(state.copyWith(isFailureOrSuccess: optionOf(right(vas))));
  }
}
