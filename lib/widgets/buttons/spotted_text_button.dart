import 'package:flutter/material.dart';
import 'package:spotted/application/dimen.dart';

enum SpottedTextButtonType {
  small,
  medium,
  large,
}

class SpottedTextButton extends StatelessWidget {
  const SpottedTextButton({
    this.type = SpottedTextButtonType.small,
    this.onTap,
    required this.text,
  });

  final SpottedTextButtonType type;
  final VoidCallback? onTap;
  final String text;

  static const double _buttonRadius = 18;
  static const double _iconSize = 25;
  static const double _colorOpacity = 0.12;

  EdgeInsets get _padding {
    switch (type) {
      case SpottedTextButtonType.small:
        return const EdgeInsets.symmetric(horizontal: Insets.large, vertical: Insets.small);
      case SpottedTextButtonType.medium:
        return const EdgeInsets.all(Insets.large);
      case SpottedTextButtonType.large:
        return const EdgeInsets.symmetric(horizontal: Insets.xLarge, vertical: Insets.large);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkResponse(
        highlightColor: Theme.of(context).accentColor.withOpacity(_colorOpacity),
        highlightShape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(_buttonRadius),
        splashColor: Colors.transparent,
        onTap: onTap,
        child: Padding(
          padding: _padding,
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
