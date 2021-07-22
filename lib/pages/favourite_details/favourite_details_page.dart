import 'package:auto_route/auto_route.dart';
import 'package:domain/model/favourite.dart';
import 'package:domain/model/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/application/application_export.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/pages/favourite_details/cubit/favourite_details_cubit.dart';
import 'package:spotted/pages/post_creation/cubit/post_creation_cubit.dart';
import 'package:spotted/pages/post_details/post_details_arguments.dart';
import 'package:spotted/widgets/tiles/post_tile.dart';
import 'package:spotted/router/app_router.gr.dart';

class FavouriteDetailsPage extends StatelessWidget with AutoRouteWrapper {
  const FavouriteDetailsPage({
    Key? key,
    required this.favourite,
  }) : super(key: key);

  final Favourite favourite;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FavouriteDetailsCubit>(
        param1: favourite,
      )..favouriteDetailsFetch(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourite Details',
          style: context.textThemes.hheadline.copyWith(
            color: Colorful.gray2,
          ),
        ),
      ),
      body: FavouriteDetailsBody(),
    );
  }
}

class FavouriteDetailsBody extends StatelessWidget {
  const FavouriteDetailsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FavouriteDetailsCubit>().state;

    if (state.isLoadingPosts) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return state.isFailureOrPosts.fold(
        () => SizedBox(),
        (either) => either.fold(
          (failure) => Center(
            child: Text('failure'),
          ),
          (result) => FavouriteDetailsPosts(
            posts: result,
          ),
        ),
      );
    }
  }
}

class FavouriteDetailsPosts extends StatelessWidget {
  const FavouriteDetailsPosts({
    Key? key,
    required this.posts,
  }) : super(key: key);

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<FavouriteDetailsCubit>().favouriteDetailsFetch(),
      child: ListView.separated(
        padding: const EdgeInsets.all(Insets.small),
        itemBuilder: (context, index) {
          return PostTile(
            onTap: () => context.router.push(
              PostDetailsRoute(
                postDetailsArguments: PostDetailsArguments(
                  commentingEnabled: false,
                  postId: posts[index].id,
                ),
              ),
            ),
            body: posts[index].body,
            creationDate: posts[index].createdAt,
            commentCount: posts[index].commentsCount,
            place: posts[index].place,
            isAnonymous: posts[index].isAnonymous,
            user: posts[index].author,
          );
        },
        itemCount: posts.length,
        separatorBuilder: (context, index) => const SizedBox(height: Insets.medium),
      ),
    );
  }
}
