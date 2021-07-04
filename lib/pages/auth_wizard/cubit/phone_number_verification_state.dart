part of 'phone_number_verification_cubit.dart';

@freezed
abstract class PhoneNumberVerificationState with _$PhoneNumberVerificationState {
  const factory PhoneNumberVerificationState({
    required bool isLoading,
    required PhoneNumberInput phoneNumberInput,
    required String countrCode,
    required bool isAgreed,
    required CodeInput codeInput,
    required bool isSuccessfulySend,
    required bool isSuccessfulVerified,
    required String verificationId,
  }) = _PhoneNumberVerificationState;

  const PhoneNumberVerificationState._();

  factory PhoneNumberVerificationState.initial() => const PhoneNumberVerificationState(
        isLoading: false,
        phoneNumberInput: PhoneNumberInput.pure(),
        countrCode: '',
        isSuccessfulySend: false,
        verificationId: '',
        isSuccessfulVerified: false,
        codeInput: CodeInput.pure(),
        isAgreed: false,
      );
  
  bool get isPhoneValid => isAgreed && phoneNumberInput.valid;
  bool get isCodeValid => codeInput.valid;
}
