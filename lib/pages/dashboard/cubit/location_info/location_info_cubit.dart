import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geo/error/error_code.dart';
import 'package:geo/service/geo_service.dart';
import 'package:geo/model/place.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_cubit.dart';
import 'package:domain/model/enum/radius_enum.dart';

part 'location_info_state.dart';
part 'location_info_cubit.freezed.dart';

class LocationInfoCubit extends Cubit<LocationInfoState> {
  LocationInfoCubit({
    required GeoManagerCubit geoManagerCubit,
    required GeoService geoService,
  })  : _geoService = geoService,
        super(LocationInfoState.initial()) {
    geoManagerCubit.stream.listen((event) async {
      await _mapGeoManagerState(event);
    });
  }

  final GeoService _geoService;

  Future<void> _mapGeoManagerState(GeoManagerState stateToMap) async {
    final newState = await stateToMap.map(
      initial: (geoState) async => state.copyWith(isLoading: true),
      load: (geoState) async {
        final result = await _geoService.placeFromCoordinates(
            lat: geoState.geoPosition.latitude, lon: geoState.geoPosition.longitude);

        return state.copyWith(
          isFailureOrPlaces: optionOf(right(result)),
          isLoading: false,
        );
      },
      failure: (geoState) async => state.copyWith(
        isFailureOrPlaces: optionOf(
          left(geoState.geoError),
        ),
        isLoading: false,
      ),
    );

    emit(newState);
  }

  void radiusChange(RadiusEnum radiusEnum) {
    emit(state.copyWith(radius: radiusEnum));
  }
}
