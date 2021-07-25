part of 'own_profile_cubit.dart';

@freezed
abstract class OwnProfileState with _$OwnProfileState {
  const factory OwnProfileState({
    required bool isProfileLoading,
    required Option<Either<Failure, User>> isFailureOrUser,
  }) = _OwnProfileState;

  const OwnProfileState._();

  factory OwnProfileState.initial() => OwnProfileState(
    isProfileLoading: true,
    isFailureOrUser: none(),
  );
}