import 'package:auto_route/auto_route.dart';
import 'package:device_preview/device_preview.dart';
import 'package:domain/service/user/user_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fire/fire_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:spotted/application/theme.dart';
import 'package:spotted/common/bloc/auth/auth_cubit.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/router/app_router.gr.dart';
import 'package:stacked_themes/stacked_themes.dart';

class SpottedApplication extends StatelessWidget {
  const SpottedApplication({
    required this.appTheme,
    required this.appRouter,
    required this.enableDevicePreview,
  });

  final AppTheme appTheme;
  final AppRouter appRouter;
  final bool enableDevicePreview;

  static const String _translationsPath = 'assets/translations';
  static const Locale _fallbackLocale = Locale('en');
  static const List<Locale> _supportedLocales = [
    _fallbackLocale,
  ];

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: enableDevicePreview,
      builder: (context) => BlocProvider(
        create: (context) => AuthCubit(
          fireAuthService: sl<FireAuthService>(),
          userService: sl<UserService>(),
        )..authCheckRequested(),
        child: EasyLocalization(
          supportedLocales: _supportedLocales,
          path: _translationsPath,
          fallbackLocale: _fallbackLocale,
          child: ThemeBuilder(
            lightTheme: appTheme.theme(LightPalette()),
            darkTheme: appTheme.theme(LightPalette()),
            builder: (context, regularTheme, darkTheme, themeMode) {
              final state = context.watch<AuthCubit>().state;
              return MaterialApp.router(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                theme: regularTheme,
                darkTheme: darkTheme,
                themeMode: themeMode,
                routerDelegate: AutoRouterDelegate.declarative(
                  appRouter,
                  routes: (_) => [
                    state.map(
                      initial: (state) => const SplashRoute(),
                      authenticate: (state) => LoggedRouter(children: [
                        if (state.authenticatedScreen == AuthenticatedScreen.nickname) ...[
                          const NicknameRoute()
                        ] else ...[
                          const NavbarRouter()
                        ],
                      ]),
                      unauthenticated: (state) => const LoginRouter(),
                    ),
                  ],
                ),
                // routerDelegate: appRouter.delegate(),
                routeInformationParser: appRouter.defaultRouteParser(),
                // builder: (context, child) {
                //   return _ResponsiveContainer(
                //     child: child,
                //   );
                // },
              );
            },
          ),
        ),
      ),
    );
  }
}

// ignore: unused_element
class _ResponsiveContainer extends StatelessWidget {
  const _ResponsiveContainer({required this.child});

  final Widget? child;

  static const double _maxWidth = 1200;
  static const double _minWidth = 480;
  static const double _lowerClampLimit = 1.0;
  static const double _upperClampLimit = 1.5;
  static const bool _defaultScale = true;
  static const List<ResponsiveBreakpoint> _responsiveBreakpoints = [
    ResponsiveBreakpoint.resize(_minWidth, name: MOBILE),
    ResponsiveBreakpoint.autoScale(800, name: TABLET),
    ResponsiveBreakpoint.resize(1000, name: DESKTOP),
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    final constrainedTextScaleFactor = mediaQueryData.textScaleFactor.clamp(
      _lowerClampLimit,
      _upperClampLimit,
    );
    return MediaQuery(
      data: mediaQueryData.copyWith(
        textScaleFactor: constrainedTextScaleFactor,
      ),
      child: ResponsiveWrapper.builder(
        child!,
        maxWidth: _maxWidth,
        minWidth: _minWidth,
        defaultScale: _defaultScale,
        breakpoints: _responsiveBreakpoints,
        background: Container(
          color: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }
}
