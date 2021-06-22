import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/pages/auth_wizard/cubit/phone_number_verification_cubit.dart';
import 'package:spotted/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotted/widgets/buttons/spotted_button.dart';
import 'package:spotted/widgets/text_forms/spotted_text_form.dart';

class PhoneNumberPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();

    return BlocListener<PhoneNumberVerificationCubit, PhoneNumberVerificationState>(
      listener: (context, state) {
        if (state.isSuccessfulySend) {
          context.read<PhoneNumberVerificationCubit>().resetState();
          context.router.push(const PhoneCodeRoute());
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.xLarge),
          child: ListView(
            children: [
              const SizedBox(height: Insets.xxLarge),
              Text(
                'Enter your phone',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: Insets.xxLarge),
              SpottedTextForm(
                keyboardType: TextInputType.phone,
                hintText: 'Phone number',
                autofocus: true,
                focusNode: focusNode,
                onChanged: (value) => context.read<PhoneNumberVerificationCubit>().phoneNumberTyped(value),
              ),
              const SizedBox(height: Insets.large),
              Align(
                child: SpottedButton(
                  onPressed: () => context.read<PhoneNumberVerificationCubit>().phoneSubmitted(),
                  text: 'Next',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
