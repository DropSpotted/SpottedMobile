import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotted/pages/splash/splash_page.dart';

class AppRouteFactory {
  Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SplashPage(),
        );
    }

    return MaterialPageRoute(
      settings: settings,
      builder: (context) => Scaffold(
        body: Center(
          child: Text(''),
        ),
      ),
    );
  }
}
