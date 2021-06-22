import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotted/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

class NavbarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        DashboardRoute(),
        OwnProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                tabsRouter.activeIndex == 0 ? Icons.explore_sharp : Icons.explore_outlined,
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(tabsRouter.activeIndex == 1 ? Icons.account_circle_sharp : Icons.account_circle_outlined),
              label: 'Account',
            ),
          ],
        );
      },
    );
  }
}
