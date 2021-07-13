import 'package:firebase_auth/firebase_auth.dart';

import 'fire_auth.dart';
import 'model/fire_user_credential.dart';
import 'model/fire_phone_auth_credential.dart';

class FireAuthImpl implements FireAuth {
  FireAuthImpl({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  @override
  bool isAuthencitcated() => _firebaseAuth.currentUser != null;

  Future<void> verifyPhoneNumber(
      {required String phoneNumber,
      Function(FirePhoneAuthCredential)? verificationCompleted,
      Function(FirebaseAuthException)? verificationFailed,
      Function(String, int?)? codeSent,
      Function(String)? codeAutoRetrievalTimeout}) async {
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (value) {
        if (verificationCompleted != null) {
          verificationCompleted(value.toFire());
        }
      },
      verificationFailed: (value) {
        if (verificationFailed != null) {
          verificationFailed(value);
        }
      },
      codeSent: (value, value1) {
        if (codeSent != null) {
          codeSent(value, value1);
        }
      },
      codeAutoRetrievalTimeout: (value) {
        if (codeAutoRetrievalTimeout != null) {
          codeAutoRetrievalTimeout(value);
        }
      },
    );
  }

  Future<FireUserCredential> signInWithPhone({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

      final result = await _firebaseAuth.signInWithCredential(credential);

      return result.toFire();
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<String> getToken() async {
    return await _firebaseAuth.currentUser?.getIdToken() ?? '';
  }
}
