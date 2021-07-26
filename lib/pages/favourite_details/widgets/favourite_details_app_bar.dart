import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotted/application/application_export.dart';
import 'package:spotted/pages/favourite_details/cubit/favourite_details/favourite_details_cubit.dart';
import 'package:spotted/pages/favourite_details/cubit/favourite_details_rename/favourite_details_rename_cubit.dart';
import 'package:spotted/pages/favourite_details/favourite_details_arguments.dart';
import 'package:spotted/pages/favourite_details/favourite_details_page.dart';
import 'package:spotted/widgets/alert_dialogs/spotted_alert_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteDetailsAppBar extends StatelessWidget with PreferredSizeWidget {
  const FavouriteDetailsAppBar({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final FavouriteDetailsArguments arguments;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FavouriteDetailsCubit>().state;

    return AppBar(
      title: Text(
        'Favourite Details',
        style: context.textThemes.hheadline.copyWith(
          color: Colorful.gray2,
        ),
      ),
      actions: [
        PopupMenuButton<FavouriteDetailsMenu>(
          onSelected: (value) async {
            switch (value) {
              case FavouriteDetailsMenu.edit:
                final result = await SpottedAlertDialog.showName(
                  context,
                  title: 'Change favourite name',
                  intitialText: state.favourite.title,
                );
                if ((result as String).isNotEmpty) {
                  await context.read<FavouriteDetailsCubit>().updateFavouriteName(result);
                  arguments.onSuccessDelete!();
                }
                break;
              case FavouriteDetailsMenu.remove:
                final result = await SpottedAlertDialog.show<bool>(
                  context,
                  title: 'Hey!',
                  subtitle: 'Do you really want to remove that favourite?',
                  agree: true,
                  disagree: false,
                );

                if (result && arguments.onSuccessDelete != null) {
                  await context.read<FavouriteDetailsCubit>().removeFavourite();
                  arguments.onSuccessDelete!();
                }
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("edit"),
              value: FavouriteDetailsMenu.edit,
            ),
            PopupMenuItem(
              child: Text("remove"),
              value: FavouriteDetailsMenu.remove,
            )
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
