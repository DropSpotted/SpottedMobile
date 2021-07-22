import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/favourite.dart';
import 'package:domain/model/post.dart';
import 'package:domain/service/post/post_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geo/service/geo_service.dart';
import 'package:spotted/common/util/place_formatter.dart';

part 'favourite_details_state.dart';
part 'favourite_details_cubit.freezed.dart';

class FavouriteDetailsCubit extends Cubit<FavouriteDetailsState> {
  FavouriteDetailsCubit(
      {required PostService postService, required Favourite favourite, required GeoService geoService})
      : _favourite = favourite,
        _postService = postService,
        _geoService = geoService,
        super(FavouriteDetailsState.initial());

  final Favourite _favourite;
  final PostService _postService;
  final GeoService _geoService;

  Future<void> favouriteDetailsFetch() async {
    emit(
      state.copyWith(
        isLoadingPosts: true,
        isFailureOrPosts: none(),
      ),
    );

    final result = await _postService.postList(
        _favourite.geoLocationCoords.coordinates.first, _favourite.geoLocationCoords.coordinates.last);

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
          if (updatePost.isNotEmpty) {
            return post.copyWith(
              place: PlaceFormatter.formatToThoroughfareAndSubLocality(updatePost.first),
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
}
