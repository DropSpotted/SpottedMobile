import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spotted/application/spotted_application.dart';
import 'package:spotted/application/theme.dart';
import 'package:spotted/router/app_router.gr.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:spotted/injector_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await ThemeManager.initialise();

  await di.init();

  runApp(
    SpottedApplication(
      appTheme: AppTheme(),
      appRouter: AppRouter(),
    ),
  );
}
