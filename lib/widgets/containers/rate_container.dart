import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotted/application/application_export.dart';

class RateContainer extends StatelessWidget {
  const RateContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colorful.gray12,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          _VoteButton(
            icon: Icons.arrow_drop_up,
            onTap: () {},
          ),
          const Text('1'),
          _VoteButton(
            icon: Icons.arrow_drop_down,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _VoteButton extends StatelessWidget {
  const _VoteButton({
    Key? key,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onTap;

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
        padding: const EdgeInsets.all(5),
        child: Icon(icon),
      ),
    );
  }
}
