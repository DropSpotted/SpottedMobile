import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_bloc.dart';
import 'package:spotted/pages/post_creation/bloc/post_creation_bloc.dart';

class PostCreationAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCreationBloc, PostCreationState>(builder: (context, state) {
      return AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (!state.lockSubmitButton) context.read<GeoManagerBloc>()..add(GeoManagerEvent.currentLocationAsked());
            },
            child: Text('Create!'),
          )
        ],
      );
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
