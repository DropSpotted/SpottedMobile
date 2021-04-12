import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_bloc.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:spotted/router/app_router.gr.dart';
import 'package:spotted/widgets/scaffolds/geo_use_scaffold.dart';
import 'package:spotted/widgets/tiles/card_tile.dart';

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
            ..add(DashboardEvent.started(
                state.geoPosition.latitude, state.geoPosition.longitude, state.includeChildLoading)),
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
            onRefresh: () async =>
                context.read<GeoManagerBloc>()..add(const GeoManagerEvent.currentLocationAsked(false)),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: Insets.small),
              itemBuilder: (context, index) {
                return CardTile(
                  post: state.posts[index],
                  onPressed: () => context.router.push(
                    const PostDetailsRoute(),
                  ),
                );
              },
              itemCount: state.posts.length,
            ),
          );
        }
      },
    );
  }
}
