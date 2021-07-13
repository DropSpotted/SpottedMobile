import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/pages/auth_wizard/cubit/phone_number_verification_cubit.dart';
import 'package:spotted/widgets/checkboxes/spotted_checkbox.dart';

class AgreeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SpottedCheckbox(onTap: (value) => context.read<PhoneNumberVerificationCubit>().checkboxChecked(value)),
        const SizedBox(width: Insets.large),
        Flexible(
          child: RichText(
            text: TextSpan(
              text: 'I agree to platform ',
              style: Theme.of(context).textTheme.caption,
              children: <TextSpan>[
                TextSpan(
                  text: 'Terms of service',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Theme.of(context).accentColor,
                      ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('dada1');
                    },
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Theme.of(context).accentColor,
                      ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('dada');
                    },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
