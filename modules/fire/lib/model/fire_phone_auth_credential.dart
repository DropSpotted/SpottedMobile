import 'package:firebase_auth/firebase_auth.dart';

import 'fire_auth_credential.dart';

class FirePhoneAuthCredential extends FireAuthCredential {
  FirePhoneAuthCredential({
    this.verificationId,
    this.smsCode,
    String? providerId,
    String? signInMethod,
    int? token,
  }) : super(
          providerId: providerId,
          signInMethod: signInMethod,
          token: token,
        );

  final String? verificationId;
  final String? smsCode;
}

extension FirePhoneAuthCredentialExtension on PhoneAuthCredential {
  FirePhoneAuthCredential toFire() {
    return FirePhoneAuthCredential(
      verificationId: verificationId,
      smsCode: smsCode,
      providerId: providerId,
      signInMethod: signInMethod,
      token: token,
    );
  }
}
