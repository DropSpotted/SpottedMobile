import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/common/bloc/auth/auth_cubit.dart';
import 'package:spotted/pages/auth_wizard/phone_number/cubit/phone_number_cubit.dart';
import 'package:spotted/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

class PhoneNumberPage extends StatelessWidget with AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneNumberCubit(),
      child: BlocListener<PhoneNumberCubit, PhoneNumberState>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.router.push(const PhoneCodeRoute());
            // context.read<AuthCubit>().authCheckRequested();
          }
        },
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(),
          ElevatedButton(
            onPressed: () => context.read<PhoneNumberCubit>().phoneSubmitted(),
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
