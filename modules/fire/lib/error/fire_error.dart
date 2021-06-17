import 'package:fire/model/fire_auth_credential.dart';

class FireError<T> {
  const FireError({
    required this.message,
    required this.code,
    this.email,
    this.credential,
    this.phoneNumber,
    this.tenantId,
  });

  /// Unique error code
  final T code;

  /// Complete error message.
  final String? message;

  /// The email of the user's account used for sign-in/linking.
  final String? email;

  /// The [FireAuthCredential] that can be used to resolve the error.
  final FireAuthCredential? credential;

  /// The phone number of the user's account used for sign-in/linking.
  final String? phoneNumber;

  /// The tenant ID being used for sign-in/linking.
  final String? tenantId;
}
