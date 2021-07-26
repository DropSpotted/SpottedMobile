import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoaderOverlay extends StatelessWidget {
  const LoaderOverlay({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            ignoring: !isLoading,
            child: AnimatedOpacity(
              opacity: isLoading ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Material(
                color: Colors.transparent,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
