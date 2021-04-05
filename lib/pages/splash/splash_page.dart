import 'package:flutter/material.dart';
import 'package:spotted/generated/easy_localization_export.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          LocaleKeys.splash.tr(),
        ),
      ),
    );
  }
}
