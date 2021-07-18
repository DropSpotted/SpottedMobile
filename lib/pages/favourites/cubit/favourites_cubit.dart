import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/favourite.dart';
import 'package:domain/service/favourite/favourite_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favourites_state.dart';
part 'favourites_cubit.freezed.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit({
    required FavouriteService favouriteService,
  })  : _favouriteService = favouriteService,
        super(FavouritesState.initial());

  final FavouriteService _favouriteService;

  Future<void> fetchFavourites() async {
    emit(state.copyWith(isLoading: true, isFailureOrSuccess: none()));
    final favourites = await _favouriteService.favouriteList();
    emit(
      favourites.fold(
        (failure) => state.copyWith(
          isLoading: false,
          isFailureOrSuccess: optionOf(
            left(failure),
          ),
        ),
        (result) => state.copyWith(
          isLoading: false,
          isFailureOrSuccess: optionOf(right(result)),
        ),
      ),
    );
  }
}
