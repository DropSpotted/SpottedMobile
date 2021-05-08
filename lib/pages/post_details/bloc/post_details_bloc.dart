import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/service/post/post_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:domain/model/detailed_post.dart';

part 'post_details_event.dart';
part 'post_details_state.dart';
part 'post_details_bloc.freezed.dart';

class PostDetailsBloc extends Bloc<PostDetailsEvent, PostDetailsState> {
  PostDetailsBloc({
    required PostService postService,
  })   : _postService = postService,
        super(const _InProgress());

  final PostService _postService;

  @override
  Stream<PostDetailsState> mapEventToState(PostDetailsEvent event) async* {
    yield* event.map(
      started: _mapStartedToState,
    );
  }

  Stream<PostDetailsState> _mapStartedToState(_Started event) async* {
    if (event.showProgress) {
      yield const PostDetailsState.inProgress();
    }

    final response = await _postService.detailedPost(event.postId);

    yield response.fold(
      (l) => const PostDetailsState.failure(),
      (r) => PostDetailsState.success(r),
    );
  }
}
