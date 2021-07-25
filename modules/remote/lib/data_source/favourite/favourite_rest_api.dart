import 'package:dio/dio.dart';
import 'package:remote/data_source/favourite/model/request/favourite_creation_model.dart';
import 'package:remote/data_source/favourite/model/response/favourite_model.dart';
import 'package:retrofit/retrofit.dart';

part 'favourite_rest_api.g.dart';

@RestApi()
abstract class FavouriteResetApi {
  factory FavouriteResetApi(Dio dio) = _FavouriteResetApi;

  @GET('/api/v1/favourites')
  Future<List<FavouriteModel>> favouriteList();
  
  @POST('/api/v1/favourites')
  Future<void> createFavourite(@Body() FavouriteCreationModel favouriteCreationModel);

  @DELETE('/api/v1/favourite/{id}/')
  Future<void> removeFavourite(@Path('id') String favouriteID);
}