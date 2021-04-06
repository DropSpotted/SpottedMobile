import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo/error/error_code.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_bloc.dart';

class GeoUseScaffold extends StatelessWidget {
  GeoUseScaffold({
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
      appBar: appBar,
      body: _GeoUseScaffoldBody(
        loadedContainer: loadedContainer,
        loadingContainer: loadingContainer,
      ),
    );
  }
}

class _GeoUseScaffoldBody extends StatelessWidget {
  _GeoUseScaffoldBody({
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
            return _GeoLoadingContainer();
          }
        },
        load: (state) => loadedContainer,
        failure: (state) => _GeoFailureContainer(state.geoError),
      );
    });
  }
}

class _GeoLoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircularProgressIndicator(),
          Text('Location accessing')
        ],
      ),
    );
  }
}

class _GeoFailureContainer extends StatelessWidget {
  _GeoFailureContainer(this.geoErrorCode);

  final GeoErrorCode geoErrorCode;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(() {
        switch (geoErrorCode) {
          case GeoErrorCode.denied:
            return 'Permission Denied';
          case GeoErrorCode.deniedForever:
            return 'Permission Denied Forever go to settings';

          case GeoErrorCode.geoLocationDisabled:
            return 'Location Disabled go to settings';
        }
      }()),
    );
  }
}
