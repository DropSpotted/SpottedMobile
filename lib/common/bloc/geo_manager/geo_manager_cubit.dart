import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geo/error/error_code.dart';
import 'package:geo/model/geo_position.dart';
import 'package:geo/service/geo_service.dart';

part 'geo_manager_state.dart';
part 'geo_manager_cubit.freezed.dart';

class GeoManagerCubit extends Cubit<GeoManagerState> {
  GeoManagerCubit({
    required GeoService geoService,
  })  : _geoService = geoService,
        super(const GeoManagerState.initial());

  final GeoService _geoService;

  Future<void> askCurrentLocation() async {
    final response = await _geoService.currentPosition();

    emit(
      response.fold(
        (error) => GeoManagerState.failure(error),
        (position) => GeoManagerState.load(position, true),
      ),
    );
  }

  Future<void> settingsOpen() async {
    await _geoService.openAppSettings();
  }

  Future<void> locationOpen() async {
    await _geoService.openLocationSettings();
  }
}
