import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotted/application/application_export.dart';

class SpottedIconButton extends StatelessWidget {
  const SpottedIconButton({
    Key? key,
    required this.icon,
    this.padding = 5,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;
  final IconData icon;
  final double padding;

  static const double _colorOpacity = 0.12;
  static const double _buttonRadius = 12;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightColor: Colorful.gray6.withOpacity(_colorOpacity),
      highlightShape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(_buttonRadius),
      splashColor: Colors.transparent,
      containedInkWell: false,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Icon(icon),
      ),
    );
  }
}
