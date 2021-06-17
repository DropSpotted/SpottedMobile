import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spotted/common/formz/nickname_formz.dart';

part 'nickname_state.dart';
part 'nickname_cubit.freezed.dart';

class NicknameCubit extends Cubit<NicknameState> {
  NicknameCubit() : super(NicknameState.initial());
}
