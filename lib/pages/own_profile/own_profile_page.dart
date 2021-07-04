import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/common/bloc/auth/auth_cubit.dart';
import 'package:spotted/pages/own_profile/widgets/profile_header_tile.dart';
import 'package:spotted/pages/own_profile/widgets/profile_list_tile.dart';
import 'package:spotted/widgets/alert_dialogs/spotted_alert_dialog.dart';

class OwnProfilePage extends StatelessWidget {
  Future<void> _onLogout(BuildContext context) async {
    final response = await SpottedAlertDialog.show(
      context,
      title: 'Wait!',
      subtitle: 'Are you sure you want to logout?',
      agree: true,
      disagree: false,
    );
    if (response) {
      await context.read<AuthCubit>().signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: Insets.xLarge),
        children: [
          const ProfileHeaderTile(title: 'My Account'),
          ProfileListTile(
            icon: Icons.account_box_outlined,
            title: 'My Posts',
            onTap: () {},
          ),
          ProfileListTile(
            icon: Icons.logout_outlined,
            title: 'Logout',
            onTap: () async => _onLogout(context),
          ),
        ],
      ),
    );
  }
}
