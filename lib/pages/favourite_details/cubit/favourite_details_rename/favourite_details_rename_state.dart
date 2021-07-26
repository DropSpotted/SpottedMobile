part of 'favourite_details_rename_cubit.dart';

@freezed
abstract class FavouriteDetailsRenameState with _$FavouriteDetailsRenameState {
  factory FavouriteDetailsRenameState({
    required FavouriteInput favouriteInput,
  }) = _FavouriteDetailsRenameState;

  const FavouriteDetailsRenameState._();

  factory FavouriteDetailsRenameState.initial(String initialName) => FavouriteDetailsRenameState(
        favouriteInput: FavouriteInput.dirty(value: initialName),
      );
}
