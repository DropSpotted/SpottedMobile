import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/widgets/buttons/spotted_button.dart';
import 'package:spotted/widgets/buttons/spotted_text_button.dart';

abstract class SpottedAlertDialog<T> {
  static Future show<T>(
    BuildContext context, {
    required String title,
    required String subtitle,
    required T agree,
    required T disagree,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return _SpottedAlertDialog(
            title: title,
            subtitle: subtitle,
            agree: agree,
            disagree: disagree,
          );
        });
  }
}

class _SpottedAlertDialog<T> extends StatelessWidget {
  const _SpottedAlertDialog({
    required this.title,
    required this.subtitle,
    required this.agree,
    required this.disagree,
  });

  final String title;
  final String subtitle;
  final T agree;
  final T disagree;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '🤔',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Insets.xxLarge),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Insets.xSmall),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Insets.xLarge),
                SpottedButton(
                  text: 'Okay',
                  onPressed: () => Navigator.of(context).pop(agree),
                ),
                SizedBox(height: Insets.xSmall),
                SpottedTextButton(
                  text: 'Dismiss',
                  onTap: () => Navigator.of(context).pop(disagree),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
