import 'package:auto_route/auto_route.dart';
import 'package:spotted/pages/dashboard/dashboard_page.dart';
import 'package:spotted/pages/landing/landing_page.dart';
import 'package:spotted/pages/post_creation/post_creation_page.dart';
import 'package:spotted/pages/splash/splash_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: SplashPage,
      path: '/splash'
      // initial: true,
    ),
    AutoRoute(
      page: LandingPage,
      path: '/landing',
    ),
    AutoRoute(
      page: DashboardPage,
      initial: true,
      // path: '/dashboard',
    ),
    AutoRoute(
      page: PostCreationPage,
      path: '/post-creation'
      // initial: true,
      // path: '/dashboard',
    ),
  ],
)
class $AppRouter {}
