import 'package:auto_route/auto_route.dart';
import 'package:domain/model/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_cubit.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/pages/dashboard/cubit/dashboard/dashboard_cubit.dart';
import 'package:spotted/pages/dashboard/cubit/favourites_creation/favorites_creation_cubit.dart';
import 'package:spotted/pages/dashboard/cubit/location_info/location_info_cubit.dart';
import 'package:spotted/pages/dashboard/widgets/dashboard_app_bar.dart';
import 'package:spotted/widgets/tiles/post_tile.dart';
import 'package:spotted/router/app_router.gr.dart';

class DashboardPage extends StatelessWidget with AutoRouteWrapper {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GeoManagerCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<DashboardCubit>()..fetchPosts(),
        ),
        BlocProvider(
          create: (context) => sl<FavoritesCreationCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<LocationInfoCubit>(),
        )
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DashboardAppBar(),
      body: DashboardBody(),
    );
  }
}

class DashboardBody extends StatelessWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DashboardCubit>().state;

    if (state.isLoadingPosts) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return state.geoErrorCode.fold(
        () => state.isFailureOrPosts.fold(
          () => const SizedBox(),
          (either) => either.fold(
            (failure) => const Center(
              child: Text('failed fetch posts'),
            ),
            (posts) => DashboardLoadedPosts(posts: posts),
          ),
        ),
        (failure) => const Center(
          child: Text('failed fetch location'),
        ),
      );
    }
  }
}

class DashboardLoadedPosts extends StatelessWidget {
  const DashboardLoadedPosts({
    Key? key,
    required this.posts,
  }) : super(key: key);

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<DashboardCubit>().fetchPosts(),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: Insets.small),
        itemBuilder: (context, index) {
          return PostTile(
            onTap: () => context.router.push(PostDetailsRoute(postId: posts[index].id)),
            body: posts[index].body,
            creationDate: posts[index].createdAt,
            commentCount: posts[index].commentsCount,
            place: posts[index].place,
            isAnonymous: posts[index].isAnonymous,
            user: posts[index].user,
          );
        },
        itemCount: posts.length,
        separatorBuilder: (context, index) => const SizedBox(height: Insets.medium),
      ),
    );
  }
}
