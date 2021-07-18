import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/application/application_export.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/pages/post_creation/cubit/post_creation_cubit.dart';
import 'package:spotted/pages/post_creation/post_creation_arguments.dart';
import 'package:spotted/pages/post_creation/widgets/post_creation_app_bar.dart';
import 'package:spotted/widgets/text_forms/spotted_multiline_text_field.dart';

class PostCreationPage extends StatelessWidget with AutoRouteWrapper {
  PostCreationPage({
    required this.postCreationArguments,
  });

  final PostCreationArguments postCreationArguments;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PostCreationCubit>(param1: postCreationArguments),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostCreationCubit, PostCreationState>(
      listener: (context, state) {
        state.failureOrSuccess.fold(
          () {},
          (either) => either.fold(
            (failure) {},
            (result) {
              if (postCreationArguments.onSuccess != null) {
                postCreationArguments.onSuccess!();
                context.router.pop();
              }
            },
          ),
        );
      },
      child: Scaffold(
        appBar: PostCreationAppBar(),
        body: SafeArea(
          child: _PostCreationTextField(),
        ),
      ),
    );
  }
}

class _PostCreationTextField extends StatelessWidget {
  static const int _maxLength = 200;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium, vertical: Insets.small),
      child: SpottedMultilineTextField(
        maxLength: _maxLength,
        onChanged: (value) => context.read<PostCreationCubit>()..typed(value),
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.newline,
      ),
    );
  }
}
