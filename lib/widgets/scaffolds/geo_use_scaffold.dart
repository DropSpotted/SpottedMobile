import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo/error/error_code.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_bloc.dart';
import 'package:spotted/widgets/containers/geo_disabled_container.dart';

class GeoUseScaffold extends StatelessWidget {
  const GeoUseScaffold({
    required this.loadedContainer,
    this.loadingContainer,
    this.appBar,
  });

  final PreferredSizeWidget? appBar;
  final Widget? loadingContainer;
  final Widget loadedContainer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _GeoUsScaffoldAppBar(appBar),
      body: _GeoUseScaffoldBody(
        loadedContainer: loadedContainer,
        loadingContainer: loadingContainer,
      ),
    );
  }
}

class _GeoUsScaffoldAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _GeoUsScaffoldAppBar(this.appBar);

  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeoManagerBloc, GeoManagerState>(
      builder: (context, state) {
        return state.maybeMap(
          load: (state) {
            if(appBar != null) {
              return appBar!;
            } else {
              return const SizedBox();
            }
          },
          orElse: () => const SizedBox(),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _GeoUseScaffoldBody extends StatelessWidget {
  const _GeoUseScaffoldBody({
    required this.loadedContainer,
    this.loadingContainer,
  });

  final Widget? loadingContainer;
  final Widget loadedContainer;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeoManagerBloc, GeoManagerState>(builder: (context, state) {
      return state.map(
        initial: (state) {
          if (loadingContainer != null) {
            return loadingContainer!;
          } else {
            return const SizedBox();
          }
        },
        load: (state) => loadedContainer,
        failure: (state) => _GeoFailureContainer(state.geoError),
      );
    });
  }
}

class _GeoFailureContainer extends StatelessWidget {
  const _GeoFailureContainer(this.geoErrorCode);

  final GeoErrorCode geoErrorCode;

  @override
  Widget build(BuildContext context) {
    switch (geoErrorCode) {
      case GeoErrorCode.denied:
        return GeoDisabledContainer.denied(
          onSettingsButtonPressed: () => context.read<GeoManagerBloc>().add(const GeoManagerEvent.settingsOpened()),
        );
      case GeoErrorCode.deniedForever:
        return GeoDisabledContainer.deniedForever(
          onSettingsButtonPressed: () => context.read<GeoManagerBloc>().add(const GeoManagerEvent.settingsOpened()),
        );
      case GeoErrorCode.geoLocationDisabled:
        return GeoDisabledContainer.locationDisabled(
          onSettingsButtonPressed: () => context.read<GeoManagerBloc>().add(const GeoManagerEvent.locationOpened()),
        );
    }
  }
}
