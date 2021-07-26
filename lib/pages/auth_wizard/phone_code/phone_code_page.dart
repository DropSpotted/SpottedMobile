import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/common/bloc/auth/auth_cubit.dart';
import 'package:spotted/pages/auth_wizard/cubit/phone_number_verification_cubit.dart';
import 'package:spotted/widgets/alert_dialogs/spotted_alert_dialog.dart';
import 'package:spotted/widgets/buttons/spotted_button.dart';
import 'package:spotted/widgets/overlay/loader_overlay.dart';

class PhoneCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneNumberVerificationCubit, PhoneNumberVerificationState>(
      listener: (context, state) async {
        await state.isErrorOrSuccessVerified.fold(
          () async {},
          (either) => either.fold(
            (failure) async {},
            (result) async => context.read<AuthCubit>().authCheckRequested(),
          ),
        );
      },
      // child: WillPopScope(
      //   onWillPop: () async {
      //     return await SpottedAlertDialog.show<bool>(
      //       context,
      //       title: 'Wait!',
      //       subtitle: 'Do your really want to quit?',
      //       agree: true,
      //       disagree: false,
      //     );
      //   },
      //   child: LoaderOverlay(
      //     isLoading: false,
      //     child: _PhoneCodeScaffold(),
      //   ),
      // ),
      buildWhen: (oldState, newState) => oldState.isLoadingCode != newState.isLoadingCode,
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            return await SpottedAlertDialog.show<bool>(
              context,
              title: 'Wait!',
              subtitle: 'Do your really want to quit?',
              agree: true,
              disagree: false,
            );
          },
          child: LoaderOverlay(
            isLoading: state.isLoadingCode,
            child: _PhoneCodeScaffold(),
          ),
        );
      },
    );
  }
}

class _PhoneCodeScaffold extends StatelessWidget {
  const _PhoneCodeScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
