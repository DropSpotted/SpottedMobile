import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/favourite_creation.dart';
import 'package:domain/service/favourite/favourite_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geo/error/error_code.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_cubit.dart';

part 'favorites_creation_state.dart';
part 'favorites_creation_cubit.freezed.dart';

class FavoritesCreationCubit extends Cubit<FavoritesCreationState> {
  FavoritesCreationCubit({
    required GeoManagerCubit geoManagerCubit,
    required FavouriteService favouriteService,
  })  : _geoManagerCubit = geoManagerCubit,
        _favouriteService = favouriteService,
        super(FavoritesCreationState.initial());

  final GeoManagerCubit _geoManagerCubit;
  final FavouriteService _favouriteService;

  Future<void> createFavourite() async {
    _geoManagerCubit.stream.listen((event) {
      _mapGeoManagerState(event);
    });

    await _geoManagerCubit.askCurrentLocation();
  }

  Future<void> _mapGeoManagerState(GeoManagerState geoManagerState) async {
    emit(
      state.copyWith(
        isLoadingFavourite: true,
        isFailureOrSuccessFavouriteCreate: none(),
      ),
    );
    final newState = await geoManagerState.map(
      initial: (geoState) async => state,
      load: (geoState) async {
        final result = await _favouriteService.createFavourite(
          FavouriteCreation(
            lat: geoState.geoPosition.latitude,
            lon: geoState.geoPosition.longitude,
            title: '',
          ),
        );
        return result.fold(
          (failure) => state.copyWith(isFailureOrSuccessFavouriteCreate: optionOf(left(failure))),
          (posts) => state.copyWith(isFailureOrSuccessFavouriteCreate: optionOf(right(unit))),
        );
      },
      failure: (geoErrorCode) async => state.copyWith(
        geoErrorCode: optionOf(geoErrorCode.geoError),
      ),
    );

    emit(
      newState.copyWith(isLoadingFavourite: false),
    );
  }
}
