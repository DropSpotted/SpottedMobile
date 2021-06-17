import 'package:firebase_auth/firebase_auth.dart';

class FireAuthCredential {
  const FireAuthCredential({
    this.providerId,
    this.signInMethod,
    this.token,
  });

  final String? providerId;
  final String? signInMethod;
  final int? token;
}

extension AuthCredentialExtension on AuthCredential {
  FireAuthCredential toFire() {
    return FireAuthCredential(
      providerId: providerId,
      signInMethod: signInMethod,
      token: token,
    );
  }
}
