import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spotted/application/theme.dart';
import 'package:spotted/router/app_route_factory.dart';
import 'package:spotted/router/app_router.gr.dart';
import 'package:stacked_themes/stacked_themes.dart';

class SpottedApplication extends StatelessWidget {
  const SpottedApplication({
    required this.appTheme,
    required this.appRouteFactory,
    required this.appRouter,
  });

  final AppTheme appTheme;
  final AppRouteFactory appRouteFactory;
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        Locale('en'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ThemeBuilder(
        lightTheme: appTheme.theme(LightPalette()),
        darkTheme: appTheme.theme(LightPalette()),
        builder: (context, regularTheme, darkTheme, themeMode) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: regularTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
            builder: (context, child) {
              final mediaQueryData = MediaQuery.of(context);

              final constrainedTextScaleFactor = mediaQueryData.textScaleFactor.clamp(1.0, 1.5);
              return MediaQuery(
                data: mediaQueryData.copyWith(
                  textScaleFactor: constrainedTextScaleFactor,
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
