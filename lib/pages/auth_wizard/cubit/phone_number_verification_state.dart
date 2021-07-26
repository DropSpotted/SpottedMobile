part of 'phone_number_verification_cubit.dart';

@freezed
abstract class PhoneNumberVerificationState with _$PhoneNumberVerificationState {
  const factory PhoneNumberVerificationState({
    required bool isLoadingNumber,
    required bool isLoadingCode,
    required PhoneNumberInput phoneNumberInput,
    required String countrCode,
    required bool isAgreed,
    required CodeInput codeInput,
    required Option<Either<FireError<SignInWithCredentialErrorCode>, Unit>> isErrorOrSuccessSend,
    required Option<Either<FireError<SignInWithCredentialErrorCode>, Unit>> isErrorOrSuccessVerified,
    required String verificationId,
  }) = _PhoneNumberVerificationState;

  const PhoneNumberVerificationState._();

  factory PhoneNumberVerificationState.initial() => PhoneNumberVerificationState(
        isLoadingNumber: false,
        isLoadingCode: false,
        phoneNumberInput: const PhoneNumberInput.pure(),
        countrCode: '',
        isErrorOrSuccessSend: none(),
        verificationId: '',
        isErrorOrSuccessVerified: none(),
        codeInput: const CodeInput.pure(),
        isAgreed: false,
      );

  bool get isPhoneValid => isAgreed && phoneNumberInput.valid;
  bool get isCodeValid => codeInput.valid;
}
