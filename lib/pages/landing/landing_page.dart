import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/application/theme.dart';
import 'package:spotted/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotted/widgets/buttons/spotted_button.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Container(decoration: BoxDecoration(),)
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.blue.withOpacity(0.4), BlendMode.luminosity),
            child: Image.network(
              'https://images.unsplash.com/photo-1533219057257-4bb9ed5d2cc6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                ],
              ),
            ),
            child: SizedBox.fromSize(size: MediaQuery.of(context).size),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                ],
              ),
            ),
            child: SizedBox.fromSize(size: MediaQuery.of(context).size),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Spacer(
                  flex: 3,
                ),
                Text(
                  'Spotted',
                  style: Theme.of(context).textTheme.headline3?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Find whats nerby you 🎉',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const Spacer(flex: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Insets.xLarge),
                  child: SpottedButton(
                    onPressed: () => context.router.push(const PhoneNumberRoute()),
                    text: 'Start your journey',
                    gradientColors: ProjectColors.purpleToBlue,
                    spottedButtonType: SpottedButtonType.large,
                  ),
                ),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
