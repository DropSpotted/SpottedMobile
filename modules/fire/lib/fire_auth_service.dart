import 'package:dartz/dartz.dart';
import 'package:fire/error/error_code.dart';
import 'package:fire/error/fire_error.dart';
import 'package:fire/model/fire_user_credential.dart';

import 'fire_auth.dart';
import 'fire_auth_service_impl.dart';
import 'model/fire_phone_auth_credential.dart';

abstract class FireAuthService {
  static FireAuthService create() => FireAuthServiceImpl(fireAuth: FireAuth.create());

  bool isAuthencitcated();

  Future<void> verifyPhoneNumber(
      {required String phoneNumber,
      Function(FirePhoneAuthCredential)? verificationCompleted,
      Function(FireError<SignInWithCredentialErrorCode>)? verificationFailed,
      Function(String, int?)? codeSent,
      Function(String)? codeAutoRetrievalTimeout});

  Future<Either<FireError<SignInWithCredentialErrorCode>, FireUserCredential>> signInWithPhone({
    required String verificationId,
    required String smsCode,
  });

  Future<void> signOut();

  Future<String> getToken();
}
