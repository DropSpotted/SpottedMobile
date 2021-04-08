import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geo/error/error_code.dart';
import 'package:geo/model/geo_position.dart';
import 'package:geo/service/geo_service.dart';

part 'geo_manager_event.dart';
part 'geo_manager_state.dart';
part 'geo_manager_bloc.freezed.dart';

class GeoManagerBloc extends Bloc<GeoManagerEvent, GeoManagerState> {
  GeoManagerBloc({
    required GeoService geoService,
  })   : _geoService = geoService,
        super(const _Initial());

  final GeoService _geoService;

  @override
  Stream<GeoManagerState> mapEventToState(GeoManagerEvent event) async* {
    yield* event.map(currentLocationAsked: _mapCurrentLocationAskedToState);
  }

  Stream<GeoManagerState> _mapCurrentLocationAskedToState(_CurrentLocationAsked event) async* {
    final response = await _geoService.currentPosition();

    yield response.fold(
      (error) => GeoManagerState.failure(error),
      (position) => GeoManagerState.load(position, event.includeChildLoading),
    );
  }
}
