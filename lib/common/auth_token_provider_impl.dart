import 'package:fire/fire_auth_service.dart';

import 'package:remote/auth_token_provider.dart';

class AuthTokenProviderImpl extends AuthTokenProvider {
  AuthTokenProviderImpl({
    required FireAuthService fireAuthService,
  }) : _fireAuthService = fireAuthService;

  final FireAuthService _fireAuthService;

  @override
  Future<String> get token async => _fireAuthService.getToken();

  // @override
  // Future<String> get firebaseMessagingToken async => _fireNotificationService.getToken();
}
