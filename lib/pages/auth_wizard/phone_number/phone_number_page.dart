import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/pages/auth_wizard/cubit/phone_number_verification_cubit.dart';
import 'package:spotted/pages/auth_wizard/phone_number/widgets/agree_container.dart';
import 'package:spotted/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotted/widgets/buttons/spotted_button.dart';

class PhoneNumberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusNode();
    print(Localizations.localeOf(context).languageCode);

    return BlocConsumer<PhoneNumberVerificationCubit, PhoneNumberVerificationState>(
      listener: (context, state) {
        if (state.isSuccessfulySend) {
          context.read<PhoneNumberVerificationCubit>().resetState();
          context.router.push(const PhoneCodeRoute());
        }
      },
      builder: (context, state) {
        print(state.isPhoneValid);
        return Scaffold(
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
                IntlPhoneField(
                  showDropdownIcon: false,
                  decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: const BorderSide(
                        width: 2.0,
                      ),
                    ),
                  ),
                  initialCountryCode: 'PL',
                  onChanged: (phone) => context.read<PhoneNumberVerificationCubit>().phoneNumberTyped(
                        phone.countryCode ?? '',
                        phone.number ?? '',
                      ),
                ),
                const SizedBox(height: Insets.xLarge),
                AgreeContainer(),
                const SizedBox(height: Insets.xLarge),
                SpottedButton(
                  isActive: state.isPhoneValid,
                  onPressed: () => context.read<PhoneNumberVerificationCubit>().phoneSubmitted(),
                  text: 'Next',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
