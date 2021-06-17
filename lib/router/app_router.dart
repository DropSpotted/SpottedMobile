import 'package:auto_route/auto_route.dart';
import 'package:spotted/pages/auth_wizard/nickname/nickname_page.dart';
import 'package:spotted/pages/auth_wizard/phone_code/phone_code_page.dart';
import 'package:spotted/pages/auth_wizard/phone_number/phone_number_page.dart';
import 'package:spotted/pages/dashboard/dashboard_page.dart';
import 'package:spotted/pages/landing/landing_page.dart';
import 'package:spotted/pages/post_creation/post_creation_page.dart';
import 'package:spotted/pages/post_details/post_details_page.dart';
import 'package:spotted/pages/splash/splash_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: SplashPage, path: '/splash',
      // initial: true,
    ),
    AutoRoute(
      page: EmptyRouterPage,
      name: 'LoggedRouter',
      children: [
        AutoRoute(
          page: DashboardPage,
          initial: true,
        ),
        AutoRoute(
          page: PostCreationPage,
          path: 'post-creation',
        ),
        AutoRoute(
          page: PostDetailsPage,
          path: 'post-details',
        ),
        AutoRoute(
          page: NicknamePage,
          path: 'nickname',
        ),
      ],
    ),
    AutoRoute(
      page: EmptyRouterPage,
      path: '/login',
      name: 'LoginRouter',
      children: [
        AutoRoute(
          page: LandingPage,
          initial: true,

          // path: 'landing',
        ),
        AutoRoute(
          page: PhoneNumberPage,
          path: 'phone-number',
        ),
        AutoRoute(
          page: PhoneCodePage,
          path: 'phone-code',
        ),
      ],
    ),
  ],
)
class $AppRouter {}
