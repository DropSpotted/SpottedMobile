import 'package:auto_route/auto_route.dart';
import 'package:domain/model/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_bloc.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:spotted/router/app_router.gr.dart';
import 'package:spotted/widgets/geo_use_scaffold.dart';

class DashboardPage extends StatelessWidget with AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GeoManagerBloc>()..add(const GeoManagerEvent.currentLocationAsked()),
        ),
        BlocProvider(
          create: (context) => sl<DashboardBloc>(),
        )
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GeoManagerBloc, GeoManagerState>(
      listener: (context, state) {
        state.map(
          initial: (state) {},
          load: (state) => context.read<DashboardBloc>()
            ..add(DashboardEvent.started(state.geoPosition.latitude, state.geoPosition.longitude)),
          failure: (state) {},
        );
      },
      child: GeoUseScaffold(
        appBar: AppBar(actions: [
          Center(
            child: IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => context.router.push(
                PostCreationRoute(
                  onSuccess: () => context.read<GeoManagerBloc>()..add(const GeoManagerEvent.currentLocationAsked()),
                ),
              ),
            ),
          )
        ]),
        loadedContainer: _DashboardList(),
      ),
    );
  }
}

class _DashboardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async => context.read<GeoManagerBloc>()..add(const GeoManagerEvent.currentLocationAsked()),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
              itemBuilder: (context, index) {
                return _CardItem(post: state.posts[index]);
              },
              itemCount: state.posts.length,
            ),
          );
        }
      },
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Color(0xffC0C0C0)),
      ),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(Insets.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  post.createdAt.toString(),
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            SizedBox(height: Insets.xSmall),
            Text(
              post.body,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }
}
