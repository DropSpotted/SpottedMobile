import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/application/colorful.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/pages/post_creation/post_creation_arguments.dart';
import 'package:spotted/pages/post_details/bloc/post_details_bloc.dart';
import 'package:spotted/widgets/tiles/post_tile.dart';
import 'package:spotted/router/app_router.gr.dart';

class PostDetailsPage extends StatelessWidget with AutoRouteWrapper {
  PostDetailsPage({
    required String postId,
  }) : _postId = postId;

  final String _postId;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PostDetailsBloc>(
        param1: _postId,
      )..add(const PostDetailsEvent.started()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _PostDetailsBody(),
      bottomNavigationBar: _BottomCommentTextField(
        parentPostId: _postId,
      ),
    );
  }
}

class _PostDetailsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostDetailsBloc, PostDetailsState>(
      builder: (context, state) {
        return state.isFailureOrLoading.fold((l) {
          return const Center(
            child: Text('failure'),
          );
        }, (isLoading) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (state.detailedPost != null) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: PostTile(
                      body: state.detailedPost!.body,
                      creationDate: state.detailedPost!.createdAt,
                      place: '',
                      isAnonymous: false,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => PostTile(
                        body: state.detailedPost!.comments[index].body,
                        creationDate: state.detailedPost!.comments[index].createdAt,
                        showLeftBorder: true,
                        place: '',
                        isAnonymous: false,
                      ),
                      childCount: state.detailedPost!.comments.length,
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text('empty'),
              );
            }
          }
        });
      },
    );
  }
}

class _BottomCommentTextField extends StatelessWidget {
  const _BottomCommentTextField({
    required this.parentPostId,
  });

  final String parentPostId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(Insets.small),
        child: Material(
          color: Colorful.alto,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: () => context.router.push(
              PostCreationRoute(
                postCreationArguments: PostCreationArguments.comment(
                  onSuccess: () => context.read<PostDetailsBloc>().add(const PostDetailsEvent.started()),
                  parentPostId: parentPostId,
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(Insets.medium),
              child: Text(
                'Comment this topic',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
