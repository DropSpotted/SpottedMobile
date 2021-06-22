import 'package:flutter/material.dart';

enum SpottedButtonType {
  small,
  medium,
  large,
}

enum SpottedButtonFillType {
  filled,
  outlined,
}

class SpottedButton extends StatelessWidget {
  const SpottedButton({
    Key? key,
    required this.text,
    this.spottedButtonType = SpottedButtonType.small,
    this.spottedButtonFillType = SpottedButtonFillType.filled,
    this.leading,
    this.trailing,
    this.onPressed,
    this.backgroundColor,
    this.backgroundGradient,
    this.textStyle,
  }) : super(key: key);

  final String text;
  final SpottedButtonType spottedButtonType;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final TextStyle? textStyle;
  final SpottedButtonFillType spottedButtonFillType;

  @override
  Widget build(BuildContext context) {
    var padding = EdgeInsets.zero;

    switch (spottedButtonType) {
      case SpottedButtonType.small:
        padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16);
        break;
      case SpottedButtonType.medium:
        padding = const EdgeInsets.all(16);
        break;
      case SpottedButtonType.large:
        padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 24);
        break;
    }

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: 20),
        ],
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            text,
            style: textStyle ?? const TextStyle(color: Colors.white),
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 20),
          trailing!,
        ],
      ],
    );

    final buttonStyle = ButtonStyle(
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
      backgroundColor: ButtonStyleButton.allOrNull<Color>(
        spottedButtonFillType == SpottedButtonFillType.filled ? backgroundColor ?? Theme.of(context).accentColor : null,
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    switch (spottedButtonFillType) {
      case SpottedButtonFillType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: buttonStyle,
          child: child,
        );
      default:
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            gradient: backgroundGradient,
          ),
          child: TextButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: child,
          ),
        );
    }
  }
}
