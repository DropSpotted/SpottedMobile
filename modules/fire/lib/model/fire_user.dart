import 'package:fire/model/fire_user_info.dart';
import 'package:fire/model/fire_user_meta_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireUser {
  const FireUser({
    this.displayName,
    this.email,
    this.emailVerified,
    this.isAnonymous,
    this.metadata,
    this.phoneNumber,
    this.photoURL,
    this.providerData,
    this.refreshToken,
    this.tenantId,
    this.uid,
  });

  final String? displayName;
  final String? email;
  final bool? emailVerified;
  final bool? isAnonymous;
  final FireUserMetaData? metadata;
  final String? phoneNumber;
  final String? photoURL;
  final List<FireUserInfo>? providerData;
  final String? refreshToken;
  final String? tenantId;
  final String? uid;
}

extension UserExtension on User {
  FireUser toFire() {
    return FireUser(
      displayName: displayName,
      email: email,
      emailVerified: emailVerified,
      isAnonymous: isAnonymous,
      metadata: metadata.toFire(),
      phoneNumber: phoneNumber,
      photoURL: photoURL,
      providerData: providerData.map((it) => it.toFire()).toList(),
      refreshToken: refreshToken,
      tenantId: tenantId,
      uid: uid,
    );
  }
}
