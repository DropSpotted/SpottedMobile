import 'package:dartz/dartz.dart';
import 'package:domain/data_source/favourite_remote_data_source.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/favourite.dart';
import 'package:domain/model/favourite_creation.dart';
import 'package:domain/model/logged_user.dart';
import 'package:domain/model/user.dart';

abstract class FavouriteService {
  Future<Either<Failure, List<Favourite>>> favouriteList();

  Future<Either<Failure, Unit>> createFavourite(FavouriteCreation favouriteCreation);
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
}
