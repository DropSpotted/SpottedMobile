import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/detailed_post.dart';
import 'package:domain/service/post/post_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geo/service/geo_service.dart';
import 'package:spotted/common/util/place_formatter.dart';

part 'post_details_state.dart';
part 'post_details_cubit.freezed.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  PostDetailsCubit({
    required PostService postService,
    required GeoService geoService,
    required String parentPostId,
  })  : _postService = postService,
        _geoService = geoService,
        super(
          PostDetailsState.initial(
            parentPostId: parentPostId,
          ),
        );

  final PostService _postService;
  final GeoService _geoService;

  Future<void> detailedPostFetch({bool showProgress = true}) async {
    if (showProgress) {
      emit(state.copyWith(isLoading: showProgress));
    }

    final response = await _postService.detailedPost(state.parentPostId);

    final newState = await response.fold(
      (failure) async => state.copyWith(
        isFailureOrDetailedPost: optionOf(
          left(failure),
        ),
      ),
      (result) async {
        final placeList = await _geoService.placeFromCoordinates(
          lat: result.geoLocationCoords.coordinates.last,
          lon: result.geoLocationCoords.coordinates.first,
        );

        var place = '';

        if (placeList.isNotEmpty) {
          place = PlaceFormatter.formatToThoroughfareAndSubLocality(placeList.first);
        }

        return state.copyWith(
          isFailureOrDetailedPost: optionOf(
            right(result.copyWith(place: place)),
          ),
        );
      },
    );

    emit(newState.copyWith(isLoading: false));
  }
}
