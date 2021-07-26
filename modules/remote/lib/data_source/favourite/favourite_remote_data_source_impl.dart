import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:domain/data_source/favourite_remote_data_source.dart';
import 'package:domain/model/favourite_creation.dart';
import 'package:domain/model/favourite_update.dart';
import 'package:domain/model/favourite.dart';
import 'package:domain/failure/failure.dart';
import 'package:remote/data_source/favourite/favourite_rest_api.dart';
import 'package:remote/data_source/favourite/favourite_failure_mapper.dart';
import 'package:remote/data_source/favourite/model/request/favourite_update_model.dart';
import 'package:remote/data_source/favourite/model/request/favourite_creation_model.dart';
import 'package:remote/data_source/favourite/model/response/favourite_model.dart';

class FavouriteRemoteDataSourceImpl implements FavouriteRemoteDataSource {
  FavouriteRemoteDataSourceImpl({required FavouriteResetApi favouriteResetApi})
      : _favouriteResetApi = favouriteResetApi;

  final FavouriteResetApi _favouriteResetApi;

  @override
  Future<Either<Failure, Unit>> createFavourite(FavouriteCreation favouriteCreation) async {
    try {
      await _favouriteResetApi.createFavourite(favouriteCreation.toRemote());
      return right(unit);
    } on DioError catch (e) {
      return left(mapDioFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<Favourite>>> favouriteList() async {
    try {
      final response = await _favouriteResetApi.favouriteList();
      return right(response.map((e) => e.toDomain()).toList());
    } on DioError catch (e) {
      return left(mapDioFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFavourite(String favoruiteId) async {
    try {
      await _favouriteResetApi.removeFavourite(favoruiteId);
      return right(unit);
    } on DioError catch (e) {
      return left(mapDioFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateFavourite(String favouriteID, FavouriteUpdate favouriteUpdate) async {
    try {
      await _favouriteResetApi.updateFavourite(favouriteID, favouriteUpdate.toRemote());
      return right(unit);
    } on DioError catch (e) {
      return left(mapDioFailure(e));
    }
  }
}
