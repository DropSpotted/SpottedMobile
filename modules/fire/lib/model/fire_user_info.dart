import 'package:firebase_auth/firebase_auth.dart';

class FireUserInfo {
  const FireUserInfo({
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    this.providerId,
    this.uid,
  });

  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  final String? providerId;
  final String? uid;
}

extension UserInfoExtension on UserInfo {
  FireUserInfo toFire() {
    return FireUserInfo(
      displayName: displayName,
      email: email,
      phoneNumber: phoneNumber,
      photoURL: photoURL,
      providerId: providerId,
      uid: uid,
    );
  }
}
