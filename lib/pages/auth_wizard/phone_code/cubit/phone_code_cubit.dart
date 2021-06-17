import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_code_state.dart';
part 'phone_code_cubit.freezed.dart';

class PhoneCodeCubit extends Cubit<PhoneCodeState> {
  PhoneCodeCubit() : super(PhoneCodeState.initial());
}
