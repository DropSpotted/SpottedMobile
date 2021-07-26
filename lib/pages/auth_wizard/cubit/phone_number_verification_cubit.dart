import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:fire/error/error_code.dart';
import 'package:fire/error/fire_error.dart';
import 'package:fire/fire_auth_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spotted/common/formz/code_formz.dart';
import 'package:spotted/common/formz/phone_number_formz.dart';
import 'package:spotted/common/sms_fill.dart';

part 'phone_number_verification_state.dart';
part 'phone_number_verification_cubit.freezed.dart';

class PhoneNumberVerificationCubit extends Cubit<PhoneNumberVerificationState> {
  PhoneNumberVerificationCubit({
    required FireAuthService fireAuthService,
    required SmsFill smsFill,
  })  : _fireAuthService = fireAuthService,
        _smsFill = smsFill,
        super(PhoneNumberVerificationState.initial());

  final FireAuthService _fireAuthService;
  final SmsFill _smsFill;

  void phoneNumberTyped(String countryCode, String number) => emit(
        state.copyWith(
          countrCode: countryCode,
          phoneNumberInput: PhoneNumberInput.dirty(value: number),
        ),
      );

  void checkboxChecked(bool value) => emit(state.copyWith(isAgreed: value));

  void codeTyped(String? code) {
    emit(
      state.copyWith(
        codeInput: CodeInput.dirty(value: code ?? ''),
      ),
    );
  }

  Future<void> initialize() async {
    await _smsFill.listenForCode();
  }

  Future<void> phoneSubmitted() async {
    emit(state.copyWith(isLoadingNumber: true));

    await _fireAuthService.verifyPhoneNumber(
      phoneNumber: state.countrCode + state.phoneNumberInput.value,
      verificationCompleted: (value) {
        print(value);
      },
      verificationFailed: (value) {
        print(value);
      },
      codeSent: (value, value2) {
        print(value);
        _codeSent(value, value2);
      },
      codeAutoRetrievalTimeout: (value) {
        print(value);
      },
    );
  }

  void _codeSent(String verificationId, int? code) {
    emit(
      state.copyWith(
        isLoadingCode: false,
        isLoadingNumber: false,
        verificationId: verificationId,
        isErrorOrSuccessSend: optionOf(right(unit)),
      ),
    );
  }

  Future<void> verifyCode() async {
    emit(
      state.copyWith(isLoadingCode: true),
    );
    final result =
        await _fireAuthService.signInWithPhone(verificationId: state.verificationId, smsCode: state.codeInput.value);

    emit(
      result.fold(
        (error) => state.copyWith(
          isErrorOrSuccessVerified: optionOf(left(error)),
          isLoadingCode: false,
          isLoadingNumber: false,
        ),
        (result) => state.copyWith(
          isErrorOrSuccessVerified: optionOf(right(unit)),
          isLoadingCode: false,
          isLoadingNumber: false,
        ),
      ),
    );
  }

  void resetState() {
    emit(
      state.copyWith(
        isLoadingNumber: false,
        isLoadingCode: false,
        isErrorOrSuccessSend: none(),
        isErrorOrSuccessVerified: none(),
      ),
    );
  }
}
