import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/application/application_export.dart';
import 'package:spotted/common/bloc/auth/auth_cubit.dart';
import 'package:spotted/pages/own_profile/widgets/profile_list_tile.dart';
import 'package:spotted/pages/own_profile/widgets/profile_sum_up_container.dart';
import 'package:spotted/widgets/alert_dialogs/spotted_alert_dialog.dart';
import 'package:spotted/widgets/buttons/spotted_icon_button.dart';
import 'package:spotted/widgets/overlay/loader_overlay.dart';

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
    return LoaderOverlay(
      isLoading: false,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: Insets.xLarge),
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: SpottedIconButton(
                  icon: Icons.settings_outlined,
                  padding: Insets.small,
                  onTap: () {},
                ),
              ),
              Text(
                'michcio53',
                style: context.textThemes.subheadline,
                textAlign: TextAlign.center,
              ),
              Text(
                'biogram',
                style: context.textThemes.caption?.copyWith(
                  color: Colorful.gray8,
                ),
              ),
              const SizedBox(height: Insets.xLarge),
              const ProfileSumUpContainer(),
              const SizedBox(height: Insets.xxLarge),
              CustomPaint(painter: DashedLinePainter()),
              const SizedBox(height: Insets.xxLarge),
              ProfileListTile(
                icon: Icons.logout_outlined,
                title: 'Logout',
                onTap: () async => _onLogout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LineDashedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..strokeWidth = 2;
    var max = 35;
    var dashWidth = 5;
    var dashSpace = 5;
    double startY = 0;
    while (max >= 0) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      final space = (dashSpace + dashWidth);
      startY += space;
      max -= space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 2, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = Colorful.gray11
      ..strokeWidth = 2;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
