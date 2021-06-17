library fire;

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';

class Fire {
  // static void crash() {
  //   FirebaseCrashlytics.instance.crash();
  // }

  static Future<void> initialize() async {
    await Firebase.initializeApp();
    // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  // static Future<void> recordError(
  //   exception,
  //   StackTrace stack, {
  //   reason,
  //   Iterable<DiagnosticsNode> information,
  //   bool /*?*/ printDetails,
  // }) =>
  //     FirebaseCrashlytics.instance.recordError(
  //       exception,
  //       stack,
  //       reason: reason,
  //       information: information,
  //       printDetails: printDetails,
  //     );
}
