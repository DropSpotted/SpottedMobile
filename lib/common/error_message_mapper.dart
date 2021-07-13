import 'package:flutter/material.dart';
import 'package:spotted/widgets/snackbars/spotted_snackbar.dart';

enum ErrorMessageCode {
  expiredOrInvalidActionCode,
  weakPassword,
  somethingWentWrong,
  incorrectEmailOrPassword,
  emailAlreadyInUse,
  accountExistsWithDifferentCredential,
  locationDisabled,
  cannotRetrieveWifiInfo,
  requiresLoginAgain,
  wrongPassword,
}

extension ErrorMessageCodeMapper on SpottedSnackbar {
  String errorMessage(BuildContext context, ErrorMessageCode? code, String? errorMessage) {
    if (errorMessage != null) {
      return errorMessage;
    } else if (code != null) {
      switch (code) {
        default:
          return 'context.strings.genericErrorMessage';
      }
    } else {
      return '';
    }
  }
}
