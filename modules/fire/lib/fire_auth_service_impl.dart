import 'package:dartz/dartz.dart';
import 'package:fire/model/fire_user_credential.dart';
import 'package:fire/model/fire_phone_auth_credential.dart';
import 'package:fire/error/fire_error.dart';
import 'package:fire/error/error_code.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'fire_auth.dart';
import 'fire_auth_service.dart';

class FireAuthServiceImpl implements FireAuthService {
  FireAuthServiceImpl({required FireAuth fireAuth}) : _fireAuth = fireAuth;

  final FireAuth _fireAuth;

  @override
  Future<Either<FireError<SignInWithCredentialErrorCode>,FireUserCredential>> signInWithPhone({required String verificationId, required String smsCode}) async {
    try {
      final credential = await _fireAuth.signInWithPhone(verificationId: verificationId, smsCode: smsCode);
      return right(credential);
    } on FirebaseAuthException catch(e) {
      return left(e.toSignInWithCredentialFireError());
    }
  }

  @override
  Future<void> verifyPhoneNumber(
      {required String phoneNumber,
      Function(FirePhoneAuthCredential)? verificationCompleted,
      Function(FireError<SignInWithCredentialErrorCode>)? verificationFailed,
      Function(String, int?)? codeSent,
      Function(String)? codeAutoRetrievalTimeout}) {
    return _fireAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: (error) {
        if (verificationFailed != null) {
          verificationFailed(error.toSignInWithCredentialFireError());
        }
      },
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  bool isAuthencitcated() => _fireAuth.isAuthencitcated();

  @override
  Future<void> signOut() => _fireAuth.signOut();

  @override
  Future<String> getToken() => _fireAuth.getToken();
}
