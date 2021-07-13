import 'dart:async';

enum AuthStreamState {
  authenticated,
  unauthenticated,
}

class AuthStreamProvider {
  AuthStreamProvider() : _controller = StreamController<AuthStreamState>();

  final StreamController<AuthStreamState> _controller;

  Stream<AuthStreamState> get authStream => _controller.stream;

  void authenticated() => _controller.add(AuthStreamState.authenticated);

  void unauthenticated() => _controller.add(AuthStreamState.unauthenticated);
}
