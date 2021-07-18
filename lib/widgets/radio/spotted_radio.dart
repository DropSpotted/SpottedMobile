import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spotted/application/colorful.dart';

class SpottedRadio<T> extends HookWidget {
  const SpottedRadio({
    Key? key,
    required this.value,
    this.groupValue,
  }) : super(key: key);

  final T value;
  final T? groupValue;

  static const double radioSize = 20;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );

    final colroAnimation = useAnimation(
      ColorTween(begin: Colorful.gray11, end: Theme.of(context).accentColor).animate(controller),
    );

    final sizeAnimation = useAnimation(Tween<double>(begin: 2.0, end: 5.0).animate(controller));


    if (value == groupValue) {
      controller.forward();
    } else {
      controller.reverse();
    }

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: sizeAnimation,
              color: colroAnimation!,
            ),
          ),
          child: const SizedBox(
            height: radioSize,
            width: radioSize,
          ),
        );
      },
    );
  }
}
