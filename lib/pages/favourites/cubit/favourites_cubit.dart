import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/favourite.dart';
import 'package:domain/service/favourite/favourite_service.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geo/service/geo_service.dart';
import 'package:spotted/common/util/place_formatter.dart';

part 'favourites_state.dart';
part 'favourites_cubit.freezed.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit({
    required FavouriteService favouriteService,
    required GeoService geoService,
  })  : _favouriteService = favouriteService,
        _geoService = geoService,
        super(FavouritesState.initial());

  final FavouriteService _favouriteService;
  final GeoService _geoService;

  static const platform = MethodChannel('samples.flutter.dev/battery');

  Future<void> fetchFavourites(double imageWidth) async {
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
        var updatedFavourites = result;
        if (Platform.isIOS) {
          updatedFavourites = await Stream.fromIterable(result).asyncMap((fav) async {
            final finalResult = await platform.invokeMethod(
              'getBatteryLevel',
              {
                'lat': fav.geoLocationCoords.coordinates.first,
                'lon': fav.geoLocationCoords.coordinates.last,
                'imgWidth': imageWidth,
              },
            );

            return fav.copyWith(iOSImage: finalResult);
          }).toList();
        }


        final updatedFavourites2 = await Stream.fromIterable(updatedFavourites).asyncMap((fav) async {
          final updateFavourite = await _geoService.placeFromCoordinates(
            lat: fav.geoLocationCoords.coordinates.first,
            lon: fav.geoLocationCoords.coordinates.last,
          );
          if (updateFavourite.isNotEmpty) {
            return fav.copyWith(
              place: PlaceFormatter.formatToFullAddress(updateFavourite.first),
            );
          } else {
            return fav;
          }
        }).toList();

        return state.copyWith(
          isLoading: false,
          isFailureOrSuccess: optionOf(right(updatedFavourites2)),
        );
      },
    );

    emit(newState);
  }
}
