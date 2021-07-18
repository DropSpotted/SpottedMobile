import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spotted/application/application_export.dart';

enum SpottedButtonType {
  small,
  medium,
  large,
}

class SpottedButton extends HookWidget {
  const SpottedButton({
    Key? key,
    required this.text,
    this.spottedButtonType = SpottedButtonType.small,
    this.leading,
    this.trailing,
    this.onPressed,
    this.backgroundColor,
    this.textStyle,
    this.gradientColors,
    this.isActive = true,
  }) : super(key: key);

  final String text;
  final SpottedButtonType spottedButtonType;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final List<Color>? gradientColors;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    var color = backgroundColor ?? Theme.of(context).accentColor;

    if (!isActive) {
      color = color.withOpacity(0.2);
    }

    final animation = useAnimationController(
      upperBound: 4.0,
      lowerBound: 0.0,
      initialValue: 4.0,
      duration: const Duration(milliseconds: 100),
    );

    LinearGradient? linearGradient;
    LinearGradient? linearGradientBackground;

    if (gradientColors != null) {
      linearGradient = LinearGradient(
        colors: gradientColors!.map((color) {
          if (isActive) {
            return color;
          } else {
            return color.withOpacity(0.2);
          }
        }).toList(),
      );
      linearGradientBackground = LinearGradient(
        colors: gradientColors!
            .map(
              (color) => color.withOpacity(0.7),
            )
            .toList(),
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      );
    }

    return GestureDetector(
      onTapCancel: () {
        if (isActive) {
          animation.forward();
        }
      },
      onTapDown: (_) {
        if (isActive) {
          animation.reverse();
        }
      },
      onTapUp: (_) {
        if (isActive) {
          animation.forward();
        }
      },
      onTap: isActive ? onPressed : null,
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          _SpottedColoredButton(
            text: text,
            type: spottedButtonType,
            color: gradientColors != null ? backgroundColor : color.withOpacity(0.2),
            gradient: linearGradientBackground,
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (context, widget) {
              return _SpottedColoredButton(
                text: text,
                type: spottedButtonType,
                color: color,
                additionalPadding: animation.value,
                gradient: linearGradient,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SpottedColoredButton extends StatelessWidget {
  const _SpottedColoredButton({
    required this.type,
    required this.text,
    this.color,
    this.gradient,
    this.additionalPadding = 4,
  });

  final SpottedButtonType type;
  final String text;
  final Color? color;
  final double additionalPadding;
  final Gradient? gradient;

  static const double _borderRadius = 14;

  EdgeInsets get _padding {
    switch (type) {
      case SpottedButtonType.small:
        return EdgeInsets.symmetric(
          vertical: 4 + additionalPadding,
          horizontal: 12 + additionalPadding,
        );
      case SpottedButtonType.medium:
        return EdgeInsets.all(12 + additionalPadding);
      case SpottedButtonType.large:
        return EdgeInsets.symmetric(
          vertical: 12 + additionalPadding,
          horizontal: 20 + additionalPadding,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4 - additionalPadding),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(_borderRadius + additionalPadding),
          gradient: gradient,
        ),
        child: Padding(
          padding: _padding,
          child: SizedBox(
            child: Text(
              text,
              style: context.textThemes.buttonLarge.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
