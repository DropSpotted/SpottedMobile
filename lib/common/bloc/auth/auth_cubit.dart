import 'package:bloc/bloc.dart';
import 'package:fire/fire_auth_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required FireAuthService fireAuthService})
      : _fireAuthService = fireAuthService,
        super(const AuthState.initial());

  final FireAuthService _fireAuthService;

  Future<void> authCheckRequested() async {
    final isAuthenticated = _fireAuthService.isAuthencitcated();

    if (isAuthenticated) {
      emit(const AuthState.authenticate(AuthenticatedScreen.dashboard));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }
}
