import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotted/router/app_router.gr.dart';
import 'package:spotted/widgets/bottom_navigation/spotted_bottom_navigation.dart';

class NavbarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        DashboardRoute(),
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
              icon: Icons.account_circle_outlined,
              value: 1,
            ),
          ],
          active: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
        );
      },
    );
  }
}
