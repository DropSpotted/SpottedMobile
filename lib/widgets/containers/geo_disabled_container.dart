import 'package:flutter/material.dart';
import 'package:spotted/application/colorful.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/widgets/buttons/rounded_text_button.dart';

class GeoDisabledContainer extends StatelessWidget {
  const GeoDisabledContainer._({
    required this.title,
    required this.subtitle,
    required this.showSettingsButton,
    required this.onSettingsButtonPressed,
  });

  factory GeoDisabledContainer.denied() {
    return GeoDisabledContainer._(
      title: 'Location Permission Denied',
      subtitle: 'Go to settings',
      showSettingsButton: true,
      onSettingsButtonPressed: () {},
    );
  }

  factory GeoDisabledContainer.deniedForever() {
    return GeoDisabledContainer._(
      title: 'Location Permission Denied Forever',
      subtitle: 'Go to settings',
      showSettingsButton: true,
      onSettingsButtonPressed: () {},
    );
  }

  factory GeoDisabledContainer.locationDisabled() {
    return GeoDisabledContainer._(
      title: 'Location Disabled',
      subtitle: 'Go to settings',
      showSettingsButton: true,
      onSettingsButtonPressed: () {},
    );
  }

  final String title;
  final String subtitle;
  final bool showSettingsButton;
  final Function() onSettingsButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: Colorful.tundora,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Insets.small),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.headline6?.copyWith(color: Colorful.gray),
          ),
          const SizedBox(height: Insets.xLarge),
          RoundedTextButton.blue(
            text: 'Go to settings',
            onPressed: onSettingsButtonPressed,
          )
        ],
      ),
    );
  }
}

class _IconContainer extends StatelessWidget {
  _IconContainer({required this.backgroundColor, required this.icon, required this.iconColor,})

  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
