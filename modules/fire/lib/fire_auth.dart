import 'package:firebase_auth/firebase_auth.dart';

import 'fire_auth_impl.dart';
import 'model/fire_phone_auth_credential.dart';
import 'model/fire_user_credential.dart';

abstract class FireAuth {
  static FireAuth create() {
    return FireAuthImpl(
      firebaseAuth: FirebaseAuth.instance,
    );
  }

  bool isAuthencitcated();

  Future<void> verifyPhoneNumber(
      {required String phoneNumber,
      Function(FirePhoneAuthCredential)? verificationCompleted,
      Function(FirebaseAuthException)? verificationFailed,
      Function(String, int?)? codeSent,
      Function(String)? codeAutoRetrievalTimeout});

  Future<FireUserCredential> signInWithPhone({
    required String verificationId,
    required String smsCode,
  });
}
