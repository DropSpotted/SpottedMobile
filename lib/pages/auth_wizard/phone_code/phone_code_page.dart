import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/common/bloc/auth/auth_cubit.dart';
import 'package:spotted/pages/auth_wizard/cubit/phone_number_verification_cubit.dart';
import 'package:spotted/widgets/alert_dialogs/spotted_alert_dialog.dart';
import 'package:spotted/widgets/buttons/spotted_button.dart';

class PhoneCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneNumberVerificationCubit, PhoneNumberVerificationState>(
      listener: (context, state) {
        if (state.isSuccessfulVerified) {
          context.read<AuthCubit>().authCheckRequested();
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          return await SpottedAlertDialog.show<bool>(
            context,
            title: 'Wait!',
            subtitle: 'Do your really want to quit?',
            agree: true,
            disagree: false,
          );
        },
        child: Scaffold(
          appBar: AppBar(),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: Insets.xLarge),
            children: [
              const SizedBox(height: Insets.xxLarge),
              Text(
                'Enter your phone',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: Insets.xxLarge),
              PinFieldAutoFill(
                codeLength: 6,
                onCodeChanged: (value) => context.read<PhoneNumberVerificationCubit>().codeTyped(value),
                // onCodeSubmitted: (value) => context.read<PhoneNumberVerificationCubit>().verifyCode(),
                autoFocus: true,
                decoration: UnderlineDecoration(
                  textStyle: Theme.of(context).textTheme.caption,
                  colorBuilder: FixedColorBuilder(Theme.of(context).accentColor),
                ),
              ),
              const SizedBox(height: Insets.xLarge),
              _NextButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<PhoneNumberVerificationCubit>().state;
    return SpottedButton(
      isActive: state.isCodeValid,
      onPressed: () => context.read<PhoneNumberVerificationCubit>().verifyCode(),
      text: 'Next',
    );
  }
}
