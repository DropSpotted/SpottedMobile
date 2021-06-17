import 'package:firebase_auth/firebase_auth.dart';

class FireUserMetaData {
  const FireUserMetaData({this.creationTime, this.lastSignInTime});

  final DateTime? creationTime;
  final DateTime? lastSignInTime;
}

extension UserMetaDataExtension on UserMetadata {
  FireUserMetaData toFire() {
    return FireUserMetaData(creationTime: creationTime, lastSignInTime: lastSignInTime);
  }
}
