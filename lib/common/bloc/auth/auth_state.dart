part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  const factory AuthState.authenticate(
    AuthenticatedScreen authenticatedScreen, {
    @Default(false) bool isLoggingOut,
  }) = _Authenticate;

  const factory AuthState.unauthenticated() = _UnAuthenticated;
}

enum AuthenticatedScreen { dashboard, nickname }
