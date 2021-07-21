import 'package:fire/fire_auth_service.dart';
import 'package:geo/service/geo_service.dart';
import 'package:get_it/get_it.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:spotted/common/auth_token_provider_impl.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_cubit.dart';
import 'package:spotted/common/sms_fill.dart';
import 'package:domain/domain_injector.dart';
import 'package:remote/remote_injector.dart';
import 'package:spotted/pages/dashboard/cubit/dashboard/dashboard_cubit.dart';
import 'package:spotted/pages/dashboard/cubit/favourites_creation/favorites_creation_cubit.dart';
import 'package:spotted/pages/dashboard/cubit/location_info/location_info_cubit.dart';
import 'package:spotted/pages/post_creation/cubit/post_creation_cubit.dart';
import 'package:spotted/pages/post_creation/post_creation_arguments.dart';
import 'package:remote/auth_token_provider.dart';
import 'package:spotted/pages/post_details/cubit/post_details_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerRemote(baseUrl: 'https://fierce-chamber-92820.herokuapp.com');
  await sl.registerDomain();

  sl
    // ..registerFactory(() => FireAuth.create())
    ..registerFactory(() => FireAuthService.create())
    ..registerFactory(() => GeoService.create())
    ..registerFactory<AuthTokenProvider>(
      () => AuthTokenProviderImpl(
        fireAuthService: sl<FireAuthService>(),
      ),
    )
    ..registerFactory(() => SmsAutoFill())
    ..registerFactory<SmsFill>(
      () => SmsFillImpl(
        smsAutoFill: sl(),
      ),
    )
    ..registerLazySingleton(
      () => GeoManagerCubit(geoService: sl()),
    )
    ..registerFactory(
      () => DashboardCubit(
        postService: sl(),
        geoManagerCubit: sl(),
        geoService: sl(),
      ),
    )
    ..registerFactory(
      () => FavoritesCreationCubit(
        geoManagerCubit: sl(),
        favouriteService: sl(),
      ),
    )
    ..registerFactory(
      () => LocationInfoCubit(
        geoManagerCubit: sl(),
        geoService: sl(),
      ),
    )
    ..registerFactoryParam<PostCreationCubit, PostCreationArguments, void>(
      (arguments, _) => PostCreationCubit(
        postCreationArguments: arguments!,
        postService: sl(),
        commentService: sl(),
        geoManagerCubit: sl(),
      ),
    )
    ..registerFactoryParam<PostDetailsCubit, String, void>(
      (arguments, _) => PostDetailsCubit(
        postService: sl(),
        parentPostId: arguments ?? '',
        geoService: sl(),
      ),
    );
}
