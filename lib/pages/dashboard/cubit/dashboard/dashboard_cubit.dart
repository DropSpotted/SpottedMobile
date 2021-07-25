import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/post.dart';
import 'package:domain/service/post/post_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geo/error/error_code.dart';
import 'package:geo/model/place.dart';
import 'package:geo/service/geo_service.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_cubit.dart';
import 'package:domain/model/enum/radius_enum.dart';
import 'package:spotted/common/util/place_formatter.dart';

part 'dashboard_state.dart';
part 'dashboard_cubit.freezed.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required GeoManagerCubit geoManagerCubit,
    required PostService postService,
    required GeoService geoService,
  })  : _geoManagerCubit = geoManagerCubit,
        _postService = postService,
        _geoService = geoService,
        super(DashboardState.initial());

  final GeoManagerCubit _geoManagerCubit;
  final GeoService _geoService;
  final PostService _postService;

  StreamSubscription? geoStreamSubscription;

  Future<void> fetchPosts({RadiusEnum? radius}) async {
    emit(
      state.copyWith(
        isLoadingPosts: true,
        isFailureOrPosts: none(),
        isFaulureOrSuccessFavouriteCreate: none(),
      ),
    );
    await geoStreamSubscription?.cancel();
    geoStreamSubscription =
        _geoManagerCubit.stream.where((event) => (event is! GeoManagerInitial)).take(1).listen((event) {
      _mapGeoManagerState(event);
    });

    await _geoManagerCubit.askCurrentLocation();
  }

  Future<void> saveFavourite() async {
    emit(state.copyWith(
      isLoadingFavourite: true,
      isFaulureOrSuccessFavouriteCreate: none(),
    ));
  }

  Future<void> _mapGeoManagerState(GeoManagerState geoManagerState, {double radius = 4000}) async {
    //
    final newState = await geoManagerState.map(
      initial: (geoState) async => state,
      load: (geoState) async {
        final result = await _postService.postList(
          geoState.geoPosition.latitude,
          geoState.geoPosition.longitude,
          radius: radius,
        );

        final foldedResult = await result.fold(
          (failure) async => state.copyWith(isFailureOrPosts: optionOf(left(failure))),
          (posts) async {
            final updatedPosts = Stream.fromIterable(posts).asyncMap((post) async {
              final updatePost = await _geoService.placeFromCoordinates(
                lat: post.geoLocationCoords.coordinates.last,
                lon: post.geoLocationCoords.coordinates.first,
              );
              final placeResult = updatePost.fold(
                (failure) => <Place>[],
                (result) => result,
              );

              if (placeResult.isNotEmpty) {
                return post.copyWith(
                  place: PlaceFormatter.formatToThoroughfareAndSubLocality(placeResult.first),
                );
              } else {
                return post;
              }
            }).toList();

            final updatePostsAwaited = await updatedPosts;

            return state.copyWith(isFailureOrPosts: optionOf(right(updatePostsAwaited)));
          },
        );
        return foldedResult;
      },
      failure: (geoErrorCode) async => state.copyWith(
        geoErrorCode: optionOf(geoErrorCode.geoError),
      ),
    );

    emit(
      newState.copyWith(isLoadingPosts: false),
    );
  }
}
