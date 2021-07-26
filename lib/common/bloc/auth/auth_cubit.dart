import 'package:bloc/bloc.dart';
import 'package:domain/service/user/user_service.dart';
import 'package:fire/fire_auth_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required FireAuthService fireAuthService, required UserService userService})
      : _fireAuthService = fireAuthService,
        _userService = userService,
        super(const AuthState.initial());

  final FireAuthService _fireAuthService;
  final UserService _userService;

  Future<void> authCheckRequested() async {
    final isAuthenticated = _fireAuthService.isAuthencitcated();

    final token = await _fireAuthService.getToken();
    print(token);

    final user = await _userService.loggedUser();

    if (isAuthenticated) {
      emit(
        user.fold(
          (failure) => const AuthState.authenticate(AuthenticatedScreen.dashboard),
          (result) {
            if (result.isUserSavedNickname) {
              return const AuthState.authenticate(AuthenticatedScreen.dashboard);
            } else {
              return const AuthState.authenticate(AuthenticatedScreen.nickname);
            }
          },
        ),
      );
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  void xd() {
    return emit(const AuthState.authenticate(AuthenticatedScreen.dashboard));
  }

  Future<void> signOut() async {
    if(state is _Authenticate) {
      emit((state as _Authenticate).copyWith(isLoggingOut: true));
    }
    await _fireAuthService.signOut();
    emit(const AuthState.unauthenticated());
  }
}
