import 'package:flutter/material.dart';
import 'package:spotted/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(
              flex: 3,
            ),
            Text(
              'Welcome to \nSpotted',
              style: Theme.of(context).textTheme.headline3,
            ),
            const Spacer(flex: 4),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () => context.router.push(const PhoneNumberRoute()),
                child: const Text('Getting Started'),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
