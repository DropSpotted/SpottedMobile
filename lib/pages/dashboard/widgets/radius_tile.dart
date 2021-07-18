import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotted/application/application_export.dart';
import 'package:spotted/widgets/radio/spotted_radio.dart';


class RadiusTile<T> extends StatelessWidget {
  const RadiusTile({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final T value;
  final T groupValue;
  final String title;
  final void Function(T) onTap;

  static const double _colorOpacity = 0.12;
  static const double _buttonRadius = 12;
  static const double _childrenSpaces = 16;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      containedInkWell: false,
      onTap: () => onTap(groupValue),
      highlightColor: Colorful.gray6.withOpacity(_colorOpacity),
      highlightShape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(_buttonRadius),
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            SpottedRadio(
              value: value,
              groupValue: groupValue,
            ),
            const SizedBox(width: _childrenSpaces),
            Flexible(child: Text(
              title,
              style: context.textThemes.buttonMedium
            ),),
          ],
        ),
      ),
    );
  }
}
