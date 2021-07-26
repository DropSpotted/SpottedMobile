import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/pages/dashboard/cubit/favourites_creation/favorites_creation_cubit.dart';
import 'package:spotted/router/app_router.gr.dart';
import 'package:spotted/widgets/bottom_navigation/spotted_bottom_navigation.dart';

class NavbarPage extends StatelessWidget with AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FavoritesCreationCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        DashboardRoute(),
        FavouritesRoute(),
        OwnProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return SpottedBottomNavigation<int>(
          items: [
            SpottedBottomNavigationItem(
              icon: Icons.explore_outlined,
              value: 0,
            ),
            SpottedBottomNavigationItem(
              icon: Icons.favorite_outline,
              value: 1,
            ),
            SpottedBottomNavigationItem(
              icon: Icons.account_circle_outlined,
              value: 2,
            ),
          ],
          active: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
        );
      },
    );
  }
}
