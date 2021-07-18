import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotted/application/application_export.dart';

enum SpottedOutlinedButtonType {
  small,
  medium,
  large,
}

class SpottedOutlinedButton extends StatelessWidget {
  const SpottedOutlinedButton({
    Key? key,
    this.type = SpottedOutlinedButtonType.small,
    this.onTap,
    required this.text,
  }) : super(key: key);

  final SpottedOutlinedButtonType type;
  final VoidCallback? onTap;
  final String text;

  static const double _buttonRadius = 16;
  static const double _colorOpacity = 0.12;

  EdgeInsets get _padding {
    switch (type) {
      case SpottedOutlinedButtonType.small:
        return const EdgeInsets.symmetric(horizontal: Insets.large, vertical: Insets.small);
      case SpottedOutlinedButtonType.medium:
        return const EdgeInsets.all(Insets.large);
      case SpottedOutlinedButtonType.large:
        return const EdgeInsets.symmetric(horizontal: Insets.xLarge, vertical: Insets.large);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_buttonRadius),
            border: Border.all(
              color: Colorful.gray11,
            )),
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
              style: context.textThemes.buttonLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
