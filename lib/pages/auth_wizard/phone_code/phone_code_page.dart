import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:spotted/common/bloc/auth/auth_cubit.dart';
import 'package:spotted/pages/auth_wizard/cubit/phone_number_verification_cubit.dart';
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
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            PinFieldAutoFill(
              codeLength: 6,
              onCodeChanged: (value) => context.read<PhoneNumberVerificationCubit>().codeTyped(value),
              onCodeSubmitted: (value) => context.read<PhoneNumberVerificationCubit>().verifyCode(),
            ),
            Align(
              child: SpottedButton(
                onPressed: () => context.read<PhoneNumberVerificationCubit>().verifyCode(),
                text: 'Next',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
