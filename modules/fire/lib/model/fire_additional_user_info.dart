import 'package:firebase_auth/firebase_auth.dart';

class FireAdditionalUserInfo {
  const FireAdditionalUserInfo({
    this.isNewUser,
    this.profile,
    this.providerId,
    this.username,
  });

  final bool? isNewUser;
  final Map<String, dynamic>? profile;
  final String? providerId;
  final String? username;
}

extension AdditionalUserInfoExtension on AdditionalUserInfo {
  FireAdditionalUserInfo toFire() {
    return FireAdditionalUserInfo(
      isNewUser: isNewUser,
      profile: profile,
      providerId: providerId,
      username: username,
    );
  }
}
