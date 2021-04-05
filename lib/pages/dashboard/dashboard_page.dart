import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/injector_container.dart';
import 'package:spotted/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:spotted/router/app_router.gr.dart';

class DashboardPage extends StatelessWidget with AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DashboardBloc>()..add(DashboardEvent.started()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
          child: Text('Add'),
          onPressed: () => context.router.push(
            PostCreationRoute(
              onSuccess: () => context.read<DashboardBloc>()..add(DashboardEvent.started()),
            ),
          ),
        ),
      ]),
      body: _DashboardList(),
    );
  }
}

class _DashboardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.posts[index].body),
              );
            },
            itemCount: state.posts.length,
          );
        }
      },
    );
  }
}
