import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spotted/application/colorful.dart';
import 'package:spotted/application/dimen.dart';

class SpottedBottomNavigationItem<T> {
  SpottedBottomNavigationItem({
    required this.value,
    required this.icon,
  });

  final T value;
  final IconData icon;
}

class SpottedBottomNavigation<T> extends StatelessWidget {
  const SpottedBottomNavigation({
    required this.items,
    required this.active,
    required this.onTap,
  });

  final List<SpottedBottomNavigationItem<T>> items;
  final T active;
  final ValueChanged<T> onTap;

  static const double _borderRadius = 26;

  @override
  Widget build(BuildContext context) {
    final rowChildren = <Widget>[];
    for (final item in items) {
      rowChildren.add(
        _SpottedBottonNavigationButton(
          isSelected: item.value == active,
          onTap: () => onTap(item.value),
          icon: item.icon,
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(_borderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            offset: const Offset(0, 4),
            blurRadius: 48,
          ),
        ],
        color: Colors.white,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Insets.medium),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: rowChildren,
          ),
        ),
      ),
    );
  }
}

class _SpottedBottonNavigationButton extends StatelessWidget {
  const _SpottedBottonNavigationButton({
    required this.icon,
    this.iconColor = Colors.blue,
    this.isSelected = false,
    this.onTap,
  });

  final Color iconColor;
  final bool isSelected;
  final IconData icon;
  final VoidCallback? onTap;

  static const double _buttonRadius = 12;
  static const double _iconSize = 25;
  static const double _colorOpacity = 0.12;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_buttonRadius),
          color: isSelected ? iconColor.withOpacity(_colorOpacity) : Colors.transparent,
        ),
        child: InkResponse(
          highlightColor: Colorful.gray6.withOpacity(_colorOpacity),
          highlightShape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(_buttonRadius),
          splashColor: Colors.transparent,
          radius: _buttonRadius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(Insets.medium),
            child: Icon(
              icon,
              size: _iconSize,
              color: isSelected ? iconColor : Colorful.gray6,
            ),
          ),
        ),
      ),
    );
  }
}
