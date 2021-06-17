part of 'nickname_cubit.dart';

@freezed
abstract class NicknameState with _$NicknameState {
  // const factory NicknameState.initial() = _Initial;

  const factory NicknameState({
    required bool isLoading,
    required NicknameInput nicknameInput,
    required bool isSuccess,
    // int? age,
    // Gender? gender,
  }) = _NicknameState;

  const NicknameState._();

  factory NicknameState.initial() => const NicknameState(
        isLoading: false,
        nicknameInput: NicknameInput.pure(),
        isSuccess: false,
      );
}
