import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/service/post/post_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:domain/model/detailed_post.dart';

part 'post_details_event.dart';
part 'post_details_state.dart';
part 'post_details_bloc.freezed.dart';

class PostDetailsBloc extends Bloc<PostDetailsEvent, PostDetailsState> {
  PostDetailsBloc({
    required PostService postService,
    required String parentPostId,
  })   : _postService = postService,
        super(
          PostDetailsState.initial(
            parentPostId: parentPostId,
          ),
        );

  final PostService _postService;

  @override
  Stream<PostDetailsState> mapEventToState(PostDetailsEvent event) async* {
    yield* event.map(
      started: _mapStartedToState,
    );
  }

  Stream<PostDetailsState> _mapStartedToState(_Started event) async* {
    if (event.showProgress) {
      yield state.copyWith(isFailureOrLoading: right(true));
      // yield const PostDetailsState.inProgress();
    }

    final response = await _postService.detailedPost(state.parentPostId);

    yield response.fold(
      (_) => state.copyWith(
        isFailureOrLoading: left(unit),
      ),
      (detailedPost) => state.copyWith(
        isFailureOrLoading: right(false),
        detailedPost: detailedPost,
      ),
    );
  }
}
