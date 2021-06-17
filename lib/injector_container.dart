import 'package:fire/fire_auth_service.dart';
import 'package:geo/service/geo_service.dart';
import 'package:get_it/get_it.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_bloc.dart';
import 'package:spotted/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:domain/domain_injector.dart';
import 'package:remote/remote_injector.dart';
import 'package:spotted/pages/post_creation/bloc/post_creation_bloc.dart';
import 'package:spotted/pages/post_creation/post_creation_arguments.dart';
import 'package:spotted/pages/post_details/bloc/post_details_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerRemote(baseUrl: 'https://fierce-chamber-92820.herokuapp.com');
  await sl.registerDomain();

  sl
    ..registerFactory(() => FireAuthService.create())
    ..registerFactory(() => GeoService.create())
    ..registerFactory(
      () => DashboardBloc(
        postService: sl(),
      ),
    )
    ..registerFactoryParam<PostCreationBloc, PostCreationArguments, void>(
      (arguments, _) => PostCreationBloc(
        postCreationArguments: arguments!,
        postService: sl(),
        commentService: sl(),
      ),
    )
    ..registerFactory(
      () => GeoManagerBloc(
        geoService: sl(),
      ),
    )
    ..registerFactoryParam<PostDetailsBloc, String, void>(
      (arguments, _) => PostDetailsBloc(
        postService: sl(),
        parentPostId: arguments ?? '',
      ),
    );
}
