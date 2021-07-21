import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/application/application_export.dart';
import 'package:spotted/application/colorful.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/pages/post_creation/post_creation_arguments.dart';
import 'package:spotted/pages/post_details/cubit/post_details_cubit.dart';
import 'package:spotted/widgets/tiles/comment_tile.dart';
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
      create: (context) => sl<PostDetailsCubit>(
        param1: _postId,
      )..detailedPostFetch(),
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
    final state = context.watch<PostDetailsCubit>().state;

    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return state.isFailureOrDetailedPost.fold(
        () => const SizedBox(),
        (either) => either.fold(
          (failure) => const Center(
            child: Text('failure'),
          ),
          (result) => ListView(
            padding: const EdgeInsets.symmetric(horizontal: Insets.small),
            children: [
              PostTile(
                body: result.body,
                creationDate: result.createdAt,
                place: result.place,
                isAnonymous: result.isAnonymous,
                commentCount: result.commentsCount,
                user: result.author,
              ),
              const SizedBox(height: Insets.xLarge),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colorful.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      ...result.comments
                          .map(
                            (comment) => CommentTile(
                              body: comment.body,
                              creationDate: comment.createdAt,
                              user: comment.user,
                            ),
                          )
                          .toList()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

class _BottomCommentTextField extends StatelessWidget {
  const _BottomCommentTextField({
    required this.parentPostId,
  });

  final String parentPostId;

  static const double _borderRadius = 16;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Insets.small),
        child: InkResponse(
          highlightColor: Colorful.gray6.withOpacity(0.12),
          highlightShape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(_borderRadius),
          splashColor: Colors.transparent,
          containedInkWell: false,
          onTap: () => context.router.push(
            PostCreationRoute(
              postCreationArguments: PostCreationArguments.comment(
                onSuccess: () => context.read<PostDetailsCubit>()..detailedPostFetch(showProgress: false),
                parentPostId: parentPostId,
              ),
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              border: Border.all(color: Colorful.gray8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Insets.large),
              child: Text(
                'Comment this topic',
                style: context.textThemes.bodySmall.copyWith(color: Colorful.gray8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
