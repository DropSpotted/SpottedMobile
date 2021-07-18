part of 'dashboard_cubit.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState(
      {required bool isLoadingPosts,
      required bool isLoadingFavourite,
      // add to posts when new page
      required Option<Either<Failure, List<Post>>> isFailureOrPosts,
      required Option<Either<Failure, Unit>> isFaulureOrSuccessFavouriteCreate,
      required Option<GeoErrorCode> geoErrorCode}) = _DashboardState;

  const DashboardState._();

  factory DashboardState.initial() => DashboardState(
      isLoadingPosts: false,
      isLoadingFavourite: false,
      isFailureOrPosts: none(),
      isFaulureOrSuccessFavouriteCreate: none(),
      geoErrorCode: none());

  bool get showAppbarIcons =>
      !isLoadingPosts &&
      geoErrorCode.isNone() &&
      isFailureOrPosts.fold(
        () => false,
        (either) => either.isRight(),
      );
}
