import 'package:domain/service/post/post_service.dart';
import 'package:get_it/get_it.dart';

extension DomainInjector on GetIt {
  Future<void> registerDomain() async {
    this
      ..registerFactory<PostService>(
        () => PostServiceImpl(
          postDataSource: get(),
        ),
      );
  }
}
