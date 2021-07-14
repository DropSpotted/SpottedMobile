part of 'nickname_cubit.dart';

@freezed
abstract class NicknameState with _$NicknameState {

  const factory NicknameState({
    required bool isLoading,
    required NicknameInput nicknameInput,
    required Option<Either<Failure, Unit>> isFailureOrSuccess,
  }) = _NicknameState;

  const NicknameState._();

  factory NicknameState.initial() =>  NicknameState(
        isLoading: false,
        nicknameInput: const NicknameInput.pure(),
        isFailureOrSuccess: none()
        // isSuccess: false,
      );
}
