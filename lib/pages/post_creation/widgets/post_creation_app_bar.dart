import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_bloc.dart';
import 'package:spotted/pages/post_creation/bloc/post_creation_bloc.dart';
import 'package:spotted/widgets/buttons/rounded_text_button.dart';

class PostCreationAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCreationBloc, PostCreationState>(builder: (context, state) {
      return AppBar(
        actions: [
          Center(
            child: RoundedTextButton.green(
              text: 'Add',
              onPressed: () {
                if (!state.lockSubmitButton) {
                  context.read<GeoManagerBloc>().add(const GeoManagerEvent.currentLocationAsked());
                }
              },
            ),
          ),
        ],
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
