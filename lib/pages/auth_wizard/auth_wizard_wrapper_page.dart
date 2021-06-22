import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/pages/auth_wizard/cubit/phone_number_verification_cubit.dart';

class AuthWizardWrapperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneNumberVerificationCubit(
        fireAuthService: sl(),
        smsFill: sl(),
      )..initialize(),
      child: const AutoRouter(),
    );
  }
}
