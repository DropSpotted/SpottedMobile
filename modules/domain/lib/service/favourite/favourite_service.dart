import 'package:dartz/dartz.dart';
import 'package:domain/data_source/favourite_remote_data_source.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/favourite.dart';
import 'package:domain/model/favourite_creation.dart';
import 'package:domain/model/favourite_update.dart';

abstract class FavouriteService {
  Future<Either<Failure, List<Favourite>>> favouriteList();

  Future<Either<Failure, Unit>> createFavourite(FavouriteCreation favouriteCreation);

  Future<Either<Failure, Unit>> deleteFavourite(String favouriteId);

  Future<Either<Failure, Unit>> updateFavourite(String favouriteID, FavouriteUpdate favouriteUpdate);
}

class FavouriteServiceImpl implements FavouriteService {
  FavouriteServiceImpl({
    required FavouriteRemoteDataSource favouriteRemoteDataSource,
  }) : _favouriteRemoteDataSource = favouriteRemoteDataSource;

  final FavouriteRemoteDataSource _favouriteRemoteDataSource;

  @override
  Future<Either<Failure, Unit>> createFavourite(FavouriteCreation favouriteCreation) async {
    return _favouriteRemoteDataSource.createFavourite(favouriteCreation);
  }

  @override
  Future<Either<Failure, List<Favourite>>> favouriteList() async {
    return _favouriteRemoteDataSource.favouriteList();
  }

  @override
  Future<Either<Failure, Unit>> deleteFavourite(String favouriteId) async {
    return _favouriteRemoteDataSource.removeFavourite(favouriteId);
  }

  @override
  Future<Either<Failure, Unit>> updateFavourite(String favouriteID, FavouriteUpdate favouriteUpdate) async {
    return _favouriteRemoteDataSource.updateFavourite(favouriteID, favouriteUpdate);
  }
}
