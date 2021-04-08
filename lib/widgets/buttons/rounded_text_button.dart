import 'package:flutter/material.dart';
import 'package:spotted/application/colorful.dart';

class RoundedTextButton extends StatelessWidget {
  const RoundedTextButton({
    this.onPressed,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
  });

  factory RoundedTextButton.green({
    Function()? onPressed,
    required String text,
  }) {
    return RoundedTextButton(
      onPressed: onPressed,
      text: text,
      textColor: Colorful.parsley,
      backgroundColor: Colorful.madanga,
    );
  }

  factory RoundedTextButton.blue({
    Function()? onPressed,
    required String text,
  }) {
    return RoundedTextButton(
      onPressed: onPressed,
      text: text,
      textColor: Colorful.white,
      backgroundColor: Colorful.toryBlue,
    );
  }

  final Function()? onPressed;
  final String text;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          backgroundColor,
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            color: textColor,
          ),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: textColor,
            ),
      ),
    );
  }
}
