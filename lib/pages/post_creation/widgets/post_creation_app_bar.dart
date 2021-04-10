import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_bloc.dart';
import 'package:spotted/generated/easy_localization_export.dart';
import 'package:spotted/pages/post_creation/bloc/post_creation_bloc.dart';
import 'package:spotted/widgets/buttons/rounded_text_button.dart';

class PostCreationAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Center(
          child: _AddPostButton(),
        ),
        const SizedBox(width: Insets.small),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AddPostButton extends StatelessWidget {
  static const Duration _animationDuration = Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCreationBloc, PostCreationState>(
      builder: (context, state) {
        return AnimatedCrossFade(
          alignment: Alignment.center,
          firstChild: const Padding(
            padding: EdgeInsets.all(Insets.small),
            child: CircularProgressIndicator(),
          ),
          secondChild: RoundedTextButton.green(
            text: LocaleKeys.add.tr(),
            onPressed: () {
              if (!state.lockSubmitButton) {
                context.read<GeoManagerBloc>().add(const GeoManagerEvent.currentLocationAsked());
              }
            },
          ),
          crossFadeState: state.isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: _animationDuration,
        );
      },
    );
  }
}
