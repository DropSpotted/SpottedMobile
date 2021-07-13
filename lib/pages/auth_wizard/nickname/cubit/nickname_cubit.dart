import 'package:bloc/bloc.dart';
import 'package:domain/service/user/user_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spotted/common/formz/nickname_formz.dart';
import 'package:domain/model/update_logged_user.dart';

part 'nickname_state.dart';
part 'nickname_cubit.freezed.dart';

class NicknameCubit extends Cubit<NicknameState> {
  NicknameCubit({required UserService userService})
      : _userService = userService,
        super(NicknameState.initial());

  final UserService _userService;

  void nicknameTyped(String nickname) => emit(
        state.copyWith(
          nicknameInput: NicknameInput.dirty(value: nickname),
        ),
      );

  Future<void> nicknameSubmitted() async {
    emit(state.copyWith(isLoading: true));

    final result = await _userService.updateUser(
      UpdateLoggedUser(username: state.nicknameInput.value, isUserSavedNickname: true),
    );

    emit(
      result.fold(
        (failure) {
          return state.copyWith(isLoading: false);
        },
        (result) {
          return state.copyWith(
            isLoading: false,
            isSuccess: true,
          );
        },
      ),
    );
  }
}
