import 'package:flutter/material.dart';
import 'package:spotted/application/colorful.dart';
import 'package:spotted/application/dimen.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    required this.title,
    this.icon,
    this.onTap,
  });

  final String title;
  final IconData? icon;
  final VoidCallback? onTap;

  static const double _colorOpacity = 0.12;
  static const double _buttonRadius = 12;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      containedInkWell: false,
      onTap: onTap,
      highlightColor: Colorful.gray6.withOpacity(_colorOpacity),
      highlightShape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(_buttonRadius),
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.large, vertical: Insets.medium),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 25),
            const SizedBox(width: Insets.large),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ),
      ),
    );
  }
}
