import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spotted/common/formz/favourite_formz.dart';

part 'favourite_details_rename_state.dart';
part 'favourite_details_rename_cubit.freezed.dart';

class FavouriteDetailsRenameCubit extends Cubit<FavouriteDetailsRenameState> {
  FavouriteDetailsRenameCubit({
    required String initialName,
  }) : super(FavouriteDetailsRenameState.initial(initialName));

  void favouriteDetailsTyped(String value) => emit(
        state.copyWith(
          favouriteInput: FavouriteInput.dirty(value: value),
        ),
      );
}
