import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SpottedCheckbox extends HookWidget {
  const SpottedCheckbox({
    required this.onTap,
    this.initialValue = false,
  });

  final ValueChanged<bool> onTap;
  final bool initialValue;

  static const double _checkboxSize = 24;
  static const double _iconSize = 16;
  static const double _checkboxRadius = 9;

  @override
  Widget build(BuildContext context) {
    final animation = useAnimationController(
      duration: const Duration(milliseconds: 100),
      upperBound: 2.0,
      lowerBound: 0,
      initialValue: 1.0,
    );

    final value = useState(initialValue);

    return GestureDetector(
      onTap: () {
        value.value = !value.value;
        if (value.value) {
          animation.forward();
        } else {
          animation.reverse();
        }
        onTap(value.value);
      },
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: value.value ? Theme.of(context).accentColor : Colors.transparent,
            borderRadius: BorderRadius.circular(_checkboxRadius),
            border: Border.all(
              color: const Color(0xffE8E8EA),
              width: animation.value,
            ),
          ),
          child: SizedBox(
            height: _checkboxSize,
            width: _checkboxSize,
            child: value.value
                ? Icon(
                    Icons.check,
                    key: ValueKey(value.value),
                    size: _iconSize,
                    color: Colors.white,
                  )
                : SizedBox(
                    key: ValueKey(value.value),
                  ),
          ),
        ),
      ),
    );
  }
}
