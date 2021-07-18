import 'package:auto_route/auto_route.dart';
import 'package:spotted/pages/auth_wizard/auth_wizard_wrapper_page.dart';
import 'package:spotted/pages/auth_wizard/nickname/nickname_page.dart';
import 'package:spotted/pages/auth_wizard/phone_code/phone_code_page.dart';
import 'package:spotted/pages/auth_wizard/phone_number/phone_number_page.dart';
import 'package:spotted/pages/dashboard/dashboard_page.dart';
import 'package:spotted/pages/favourites/favourites_page.dart';
import 'package:spotted/pages/landing/landing_page.dart';
import 'package:spotted/pages/navbar/navbar_page.dart';
import 'package:spotted/pages/own_profile/own_profile_page.dart';
import 'package:spotted/pages/post_creation/post_creation_page.dart';
import 'package:spotted/pages/post_details/post_details_page.dart';
import 'package:spotted/pages/splash/splash_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: SplashPage,
      path: '/splash',
    ),
    AutoRoute(
      name: 'LoggedRouter',
      initial: true,
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          // name: 'NavbarRouter',
          page: NavbarPage,
          children: [
            AutoRoute(
              page: DashboardPage,
              // initial: true,
              path: '',
            ),
            AutoRoute(
              page: FavouritesPage,
              // initial: true,
              path: 'favourites',
            ),
            AutoRoute(
              page: OwnProfilePage,
              path: 'own-profile',
            ),
          ],
        ),
        AutoRoute(
          page: PostCreationPage,
          path: 'post-creation',
        ),
        AutoRoute(
          page: PostDetailsPage,
          path: 'post-details',
        ),
      ],
    ),
    AutoRoute(
      name: 'LoggedWizardRouter',
      path: '/logged-wiazrd',
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          page: NicknamePage,
          initial: true,
          path: 'nickname',
        ),
      ],
    ),
    AutoRoute(
      page: AuthWizardWrapperPage,
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
