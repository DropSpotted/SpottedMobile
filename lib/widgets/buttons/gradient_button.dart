import 'package:flutter/material.dart';
import 'package:spotted/application/theme.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: ProjectColors.purpleToBlue,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          'Register',
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
