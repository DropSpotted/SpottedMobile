part of 'phone_number_cubit.dart';

@freezed
class PhoneNumberState with _$PhoneNumberState {
  // const factory PhoneNumberState.initial() = _Initial;
  const factory PhoneNumberState({
    required bool isLoading,
    required PhoneNumberInput phoneNumberInput,
    required bool isSuccess,
    // int? age,
    // Gender? gender,
  }) = _PhoneNumberState;

  const PhoneNumberState._();

  factory PhoneNumberState.initial() => const PhoneNumberState(
        isLoading: false,
        phoneNumberInput: PhoneNumberInput.pure(),
        isSuccess: false,
      );
}
