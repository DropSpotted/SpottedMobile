part of 'phone_code_cubit.dart';

@freezed
abstract class PhoneCodeState with _$PhoneCodeState {
  
  const factory PhoneCodeState({
    required bool isLoading,
    required String smsCode,
    required bool isSuccess,
  }) = _PhoneCodeState;

  const PhoneCodeState._();

  factory PhoneCodeState.initial() => const PhoneCodeState(
        isLoading: false,
        smsCode: '',
        isSuccess: false,
      );
}
