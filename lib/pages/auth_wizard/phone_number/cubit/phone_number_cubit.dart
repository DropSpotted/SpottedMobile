import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spotted/common/formz/phone_number_formz.dart';

part 'phone_number_state.dart';
part 'phone_number_cubit.freezed.dart';

class PhoneNumberCubit extends Cubit<PhoneNumberState> {
  PhoneNumberCubit() : super(PhoneNumberState.initial());

  void phoneNumberTyped(String phoneNumber) => emit(
        state.copyWith(
          phoneNumberInput: PhoneNumberInput.dirty(
            value: phoneNumber,
          ),
        ),
      );

  Future<void> phoneSubmitted() async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(isLoading: false, isSuccess: true));
  }
}
