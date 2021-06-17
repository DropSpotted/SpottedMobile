import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState.initial());

  Future<void> authCheckRequested() async {
    // await Future.delayed(const Duration(milliseconds: 3));

    emit(AuthState.unauthenticated());

    // emit(AuthState.authenticate(AuthenticatedScreen.nickname));
  }
}
