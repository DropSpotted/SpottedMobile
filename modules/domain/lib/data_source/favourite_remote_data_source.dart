import 'package:dartz/dartz.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/favourite.dart';
import 'package:domain/model/favourite_creation.dart';

abstract class FavouriteRemoteDataSource {
  Future<Either<Failure,List<Favourite>>> favouriteList();
  
  Future<Either<Failure,Unit>> createFavourite(FavouriteCreation favouriteCreation);
}
