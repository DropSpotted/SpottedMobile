import 'package:auto_route/auto_route.dart';
import 'package:domain/failure/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/common/bloc/auth/auth_cubit.dart';
import 'package:spotted/common/extensions/api_error_mapper.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/pages/auth_wizard/nickname/cubit/nickname_cubit.dart';
import 'package:spotted/widgets/buttons/spotted_button.dart';
import 'package:spotted/widgets/snackbars/spotted_snackbar.dart';
import 'package:spotted/widgets/text_forms/spotted_text_form.dart';

class NicknamePage extends StatelessWidget with AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => NicknameCubit(
        userService: sl(),
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NicknameCubit, NicknameState>(
      listener: (context, state) {
        state.isFailureOrSuccess.fold(
          () {},
          (either) => either.fold(
            (failure) => SpottedSnackbar.showError(
              context,
              message: failure.errorMap(context),
            ),
            (success) {
              context.read<AuthCubit>().authCheckRequested();
            },
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: Insets.xLarge),
          children: [
            const SizedBox(height: Insets.xxLarge),
            Text(
              'Choose your nickname',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: Insets.xxLarge),
            SpottedTextForm(
              textCapitalization: TextCapitalization.none,
              onChanged: (value) => context.read<NicknameCubit>().nicknameTyped(value),
            ),
            const SizedBox(height: Insets.xLarge),
            _NicknameSubmitButton()
          ],
        ),
      ),
    );
  }
}

class _NicknameSubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<NicknameCubit>().state;
    return SpottedButton(
      isActive: state.nicknameInput.valid,
      onPressed: () => context.read<NicknameCubit>().nicknameSubmitted(),
      text: 'Next',
    );
  }
}
