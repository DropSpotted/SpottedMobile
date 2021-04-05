import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_bloc.dart';
import 'package:spotted/common/formz/post_formz.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/pages/post_creation/bloc/post_creation_bloc.dart';
import 'package:spotted/pages/post_creation/widgets/post_creation_app_bar.dart';

class PostCreationPage extends StatelessWidget with AutoRouteWrapper {
  PostCreationPage({
    this.onSuccess,
  });

  final Function()? onSuccess;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GeoManagerBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<PostCreationBloc>(),
          child: this,
        ),
      ],
      child: this,
    );
    // return BlocProvider(
    //   create: (context) => sl<PostCreationBloc>(),
    //   child: this,
    // );
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
              load: (state) {
                context.read<PostCreationBloc>()
                  ..add(PostCreationEvent.submitted(state.geoPosition.latitude, state.geoPosition.longitude));
              },
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
  String? _errorText(PostInputError? postInputError) {
    switch (postInputError) {
      case PostInputError.empty:
        return 'Empty';
      case PostInputError.toManyCharacters:
        return 'To much chars!';
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCreationBloc, PostCreationState>(
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.multiline,
          maxLines: 100,
          maxLength: 200,
          onChanged: (value) => context.read<PostCreationBloc>()..add(PostCreationEvent.typed(value)),
          autofocus: true,
          decoration: InputDecoration(
            errorText: _errorText(state.postInput.error),
          ),
        );
      },
    );
  }
}
