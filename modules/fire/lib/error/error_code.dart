import 'package:fire/error/fire_error.dart';
import 'package:fire/model/fire_auth_credential.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum SignInWithCredentialErrorCode {
  accountExistsWithDifferentCredential,
  invalidCredential,
  operationNotAllowed,
  userDisabled,
  userNotFound,
  wrongPassword,
  invalidVerificationCode,
  invalidVerificationId,
  abort
}


extension FirebaseAuthExceptionExtension on FirebaseAuthException {
  FireError<SignInWithCredentialErrorCode> toSignInWithCredentialFireError() {
    var errorCode = SignInWithCredentialErrorCode.userNotFound;
    switch (code) {
      case 'account-exists-with-different-credential':
        errorCode = SignInWithCredentialErrorCode.accountExistsWithDifferentCredential;
        break;
      case 'invalid-credential':
        errorCode = SignInWithCredentialErrorCode.invalidCredential;
        break;
      case 'operation-not-allowed':
        errorCode = SignInWithCredentialErrorCode.operationNotAllowed;
        break;
      case 'user-disabled':
        errorCode = SignInWithCredentialErrorCode.userDisabled;
        break;
      case 'user-not-found':
        errorCode = SignInWithCredentialErrorCode.userNotFound;
        break;
      case 'wrong-password':
        errorCode = SignInWithCredentialErrorCode.wrongPassword;
        break;
      case 'invalid-verification-code':
        errorCode = SignInWithCredentialErrorCode.invalidVerificationCode;
        break;
      case 'invalid-verification-id':
        errorCode = SignInWithCredentialErrorCode.invalidVerificationId;
        break;
    }

    return FireError<SignInWithCredentialErrorCode>(
      message: message,
      code: errorCode,
      email: email,
      credential: credential?.toFire(),
      phoneNumber: phoneNumber,
      tenantId: tenantId,
    );
  }
}