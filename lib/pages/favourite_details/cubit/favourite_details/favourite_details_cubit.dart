import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/favourite.dart';
import 'package:domain/model/favourite_update.dart';
import 'package:domain/model/post.dart';
import 'package:domain/service/favourite/favourite_service.dart';
import 'package:domain/service/post/post_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geo/model/place.dart';
import 'package:geo/service/geo_service.dart';
import 'package:spotted/common/util/place_formatter.dart';
import 'package:spotted/pages/favourite_details/favourite_details_arguments.dart';

part 'favourite_details_state.dart';
part 'favourite_details_cubit.freezed.dart';

class FavouriteDetailsCubit extends Cubit<FavouriteDetailsState> {
  FavouriteDetailsCubit({
    required PostService postService,
    required FavouriteDetailsArguments arguments,
    required GeoService geoService,
    required FavouriteService favouriteService,
  })  : _postService = postService,
        _geoService = geoService,
        _favouriteService = favouriteService,
        super(FavouriteDetailsState.initial(arguments.favourite));

  final PostService _postService;
  final GeoService _geoService;
  final FavouriteService _favouriteService;

  Future<void> favouriteDetailsFetch() async {
    emit(
      state.copyWith(
        isLoadingPosts: true,
        isFailureOrPosts: none(),
      ),
    );

    final result = await _postService.postList(
        state.favourite.geoLocationCoords.coordinates.first, state.favourite.geoLocationCoords.coordinates.last);

    final newState = await result.fold(
      (failure) async => state.copyWith(
        isFailureOrPosts: optionOf(
          left(failure),
        ),
      ),
      (result) async {
        final updatedPosts = await Stream.fromIterable(result).asyncMap((post) async {
          final updatePost = await _geoService.placeFromCoordinates(
            lat: post.geoLocationCoords.coordinates.last,
            lon: post.geoLocationCoords.coordinates.first,
          );

          final resultPlace = updatePost.fold((failure) => <Place>[], (result) => result);
          if (resultPlace.isNotEmpty) {
            return post.copyWith(
              place: PlaceFormatter.formatToThoroughfareAndSubLocality(resultPlace.first),
            );
          } else {
            return post;
          }
        }).toList();

        return state.copyWith(isFailureOrPosts: optionOf(right(updatedPosts)));
      },
    );

    emit(newState.copyWith(isLoadingPosts: false));
  }

  Future<void> removeFavourite() async {
    emit(
      state.copyWith(
        isFailureOrRemoved: none(),
        isModifyFav: true,
      ),
    );

    final result = await _favouriteService.deleteFavourite(state.favourite.id);

    emit(
      result.fold(
        (failure) => state.copyWith(
          isFailureOrRemoved: optionOf(left(failure)),
          isModifyFav: false,
        ),
        (result) => state.copyWith(
          isFailureOrRemoved: optionOf(right(result)),
          isModifyFav: false,
        ),
      ),
    );
  }

  Future<void> updateFavouriteName(String favoriteName) async {
    emit(
      state.copyWith(
        isFailureOrRenamed: none(),
        isModifyFav: true,
      ),
    );

    final result = await _favouriteService.updateFavourite(
      state.favourite.id,
      FavouriteUpdate(
        title: favoriteName,
      ),
    );

    emit(
      result.fold(
        (failure) => state.copyWith(
          isFailureOrRenamed: optionOf(left(failure)),
          isModifyFav: false,
        ),
        (result) => state.copyWith(
          favourite: state.favourite.copyWith(title: favoriteName),
          isFailureOrRenamed: optionOf(right(result)),
          isModifyFav: false,
        ),
      ),
    );
  }
}
