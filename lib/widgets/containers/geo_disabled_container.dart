import 'package:flutter/material.dart';
import 'package:spotted/application/colorful.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/generated/easy_localization_export.dart';
import 'package:spotted/widgets/buttons/rounded_text_button.dart';

class GeoDisabledContainer extends StatelessWidget {
  const GeoDisabledContainer._({
    required this.title,
    required this.subtitle,
    required this.showSettingsButton,
    required this.onSettingsButtonPressed,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
  });

  factory GeoDisabledContainer.denied({
    required Function() onSettingsButtonPressed,
  }) {
    return GeoDisabledContainer._(
      title: LocaleKeys.location_denied.tr(),
      subtitle: LocaleKeys.go_to_settings_and_update_permission.tr(),
      showSettingsButton: true,
      onSettingsButtonPressed: onSettingsButtonPressed,
      backgroundColor: Colorful.cinderella,
      icon: Icons.location_off_outlined,
      iconColor: Colorful.razzmatazz,
    );
  }

  factory GeoDisabledContainer.deniedForever({
    required Function() onSettingsButtonPressed,
  }) {
    return GeoDisabledContainer._(
      title: LocaleKeys.location_denied.tr(),
      subtitle: LocaleKeys.go_to_settings_and_update_permission.tr(),
      showSettingsButton: true,
      onSettingsButtonPressed: onSettingsButtonPressed,
      backgroundColor: Colorful.cinderella,
      icon: Icons.location_off_outlined,
      iconColor: Colorful.razzmatazz,
    );
  }

  factory GeoDisabledContainer.locationDisabled({
    required Function() onSettingsButtonPressed,
  }) {
    return GeoDisabledContainer._(
      title: LocaleKeys.location_disabled.tr(),
      subtitle: LocaleKeys.go_to_settings_and_enable_location.tr(),
      showSettingsButton: true,
      onSettingsButtonPressed: onSettingsButtonPressed,
      backgroundColor: Colorful.cinderella,
      icon: Icons.near_me_disabled_outlined,
      iconColor: Colorful.razzmatazz,
    );
  }

  final String title;
  final String subtitle;
  final bool showSettingsButton;
  final Function() onSettingsButtonPressed;
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: Insets.xLarge),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _IconContainer(
              backgroundColor: backgroundColor,
              icon: icon,
              iconColor: iconColor,
            ),
            const SizedBox(height: Insets.xLarge),
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
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Insets.xLarge),
            RoundedTextButton.blue(
              text: LocaleKeys.go_to_settings.tr(),
              onPressed: onSettingsButtonPressed,
            )
          ],
        ),
      ),
    );
  }
}

class _IconContainer extends StatelessWidget {
  const _IconContainer({
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
  });

  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;

  static const double _containerSize = 120;
  static const double _iconSize = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _containerSize,
      width: _containerSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: backgroundColor,
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
          size: _iconSize,
        ),
      ),
    );
  }
}
