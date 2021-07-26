import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/pages/favourite_details/cubit/favourite_details_rename/favourite_details_rename_cubit.dart';
import 'package:spotted/widgets/buttons/spotted_button.dart';
import 'package:spotted/widgets/buttons/spotted_text_button.dart';
import 'package:spotted/widgets/text_forms/spotted_text_form.dart';

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

  static Future showName<bool>(
    BuildContext context, {
    required String title,
    String? intitialText,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return BlocProvider(
            create: (context) => FavouriteDetailsRenameCubit(
              initialName: intitialText ?? '',
            ),
            child: _SpottedAlertName(
              title: title,
              inititalText: intitialText,
            ),
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
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '🤔',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Insets.xxLarge),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Insets.xSmall),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Insets.xLarge),
                SpottedButton(
                  text: 'Okay',
                  onPressed: () => Navigator.of(context).pop(agree),
                ),
                const SizedBox(height: Insets.xSmall),
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

class _SpottedAlertName extends HookWidget {
  const _SpottedAlertName({
    required this.title,
    this.inititalText,
  });

  final String title;
  final String? inititalText;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(
      text: inititalText,
    );

    final state = context.watch<FavouriteDetailsRenameCubit>().state;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Insets.xSmall),
                SpottedTextForm(
                  controller: controller,
                  onChanged: (value) => context.read<FavouriteDetailsRenameCubit>().favouriteDetailsTyped(value),
                ),
                const SizedBox(height: Insets.xLarge),
                SpottedButton(
                  isActive: state.favouriteInput.valid,
                  text: 'Submit',
                  onPressed: () => Navigator.of(context).pop(
                    context.read<FavouriteDetailsRenameCubit>().state.favouriteInput.value,
                  ),
                ),
                const SizedBox(height: Insets.xSmall),
                SpottedTextButton(
                  text: 'Dismiss',
                  onTap: () => Navigator.of(context).pop(''),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
