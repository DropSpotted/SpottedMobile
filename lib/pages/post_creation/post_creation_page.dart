import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_bloc.dart';
import 'package:spotted/common/formz/post_formz.dart';
import 'package:spotted/generated/easy_localization_export.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/pages/post_creation/bloc/post_creation_bloc.dart';
import 'package:spotted/pages/post_creation/post_creation_arguments.dart';
import 'package:spotted/pages/post_creation/widgets/post_creation_app_bar.dart';

class PostCreationPage extends StatelessWidget with AutoRouteWrapper {
  PostCreationPage({
    required this.postCreationArguments,
    // required this.creationType,
    // this.onSuccess,
  });

  final PostCreationArguments postCreationArguments;

  // final Function()? onSuccess;
  // final CreationType creationType;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GeoManagerBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<PostCreationBloc>(param1: creationType),
          child: this,
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PostCreationBloc, PostCreationState>(
          listener: (context, state) {
            if (state.isSuccess && onSuccess != null) {
              onSuccess!();
              context.router.pop();
            }
          },
        ),
        BlocListener<GeoManagerBloc, GeoManagerState>(
          listener: (context, state) {
            state.map(
              initial: (state) {},
              load: (state) => context.read<PostCreationBloc>()
                ..add(PostCreationEvent.submitted(state.geoPosition.latitude, state.geoPosition.longitude)),
              failure: (state) {},
            );
          },
        )
      ],
      child: Scaffold(
        appBar: PostCreationAppBar(),
        body: _PostCreationTextField(),
      ),
    );
  }
}

class _PostCreationTextField extends StatelessWidget {
  static const int _maxLength = 200;
  static const int _maxLines = 100;
  static const bool _autofocus = true;

  String? _errorText(PostInputError? postInputError, bool invalid) {
    if (invalid) {
      switch (postInputError) {
        case PostInputError.empty:
          return LocaleKeys.post_cannot_be_empty.tr();
        case PostInputError.toManyCharacters:
          return LocaleKeys.post_cannot_have_more_than.tr();
        default:
          return null;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCreationBloc, PostCreationState>(
      buildWhen: (previous, current) => previous.postInput != current.postInput,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.medium, vertical: Insets.small),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: _maxLines,
            maxLength: _maxLength,
            onChanged: (value) => context.read<PostCreationBloc>()..add(PostCreationEvent.typed(value)),
            autofocus: _autofocus,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
              errorText: _errorText(state.postInput.error, state.postInput.invalid),
              hintText: LocaleKeys.what_are_you_thinking_about_now.tr(),
            ),
          ),
        );
      },
    );
  }
}
