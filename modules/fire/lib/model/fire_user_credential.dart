import 'package:fire/model/fire_additional_user_info.dart';
import 'package:fire/model/fire_auth_credential.dart';
import 'package:fire/model/fire_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireUserCredential {
  const FireUserCredential({
    this.additionalUserInfo,
    this.credential,
    this.user,
  });

  final FireAdditionalUserInfo? additionalUserInfo;
  final FireAuthCredential? credential;
  final FireUser? user;
}

extension UserCredentialExtension on UserCredential {
  FireUserCredential toFire() {
    return FireUserCredential(
      additionalUserInfo: additionalUserInfo?.toFire(),
      credential: credential?.toFire(),
      user: user?.toFire(),
    );
  }
}
