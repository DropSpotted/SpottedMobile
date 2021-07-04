import 'package:flutter/material.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/pages/own_profile/widgets/profile_list_tile.dart';

class ProfileHeaderTile extends StatelessWidget {
  const ProfileHeaderTile({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.large),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
