import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/model/post_creation.dart';
import 'package:domain/service/comment/comment_service.dart';
import 'package:domain/service/post/post_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spotted/common/formz/post_formz.dart';
import 'package:spotted/pages/post_creation/post_creation_arguments.dart';

part 'post_creation_event.dart';
part 'post_creation_state.dart';
part 'post_creation_bloc.freezed.dart';

class PostCreationBloc extends Bloc<PostCreationEvent, PostCreationState> {
  PostCreationBloc({
    required PostService postService,
    required CommentService commentService,
    required PostCreationArguments postCreationArguments,
  })   : _postService = postService,
        _commentService = commentService,
        super(PostCreationState.initial(
          creationType: postCreationArguments.creationType,
          parentPostId: postCreationArguments.parentPostId,
        ));

  final PostService _postService;
  final CommentService _commentService;

  @override
  Stream<PostCreationState> mapEventToState(PostCreationEvent event) async* {
    yield* event.map(
      typed: _mapTypedToState,
      submitted: _mapSubmittedToState,
    );
  }

  Stream<PostCreationState> _mapTypedToState(_Typed event) async* {
    yield state.copyWith(
      postInput: PostInput.dirty(
        value: event.text,
      ),
    );
  }

  Stream<PostCreationState> _mapSubmittedToState(_Submitted event) async* {
    yield state.copyWith(isLoading: true);
    switch (state.creationType) {
      case CreationType.post:
        final createdPostResponse = await _postService.createPost(
          PostCreation(body: state.postInput.value, lat: event.lon, lon: event.lat),
        );

        yield createdPostResponse.fold(
          (l) => state.copyWith(isSuccess: false, isLoading: false),
          (r) => state.copyWith(isSuccess: true, isLoading: false),
        );
        break;
      case CreationType.comment:
        final createdCommentResponse = await _commentService.createComment(
          state.parentPostId ?? '',
          state.postInput.value,
        );

        yield createdCommentResponse.fold(
          (l) => state.copyWith(isSuccess: false, isLoading: false),
          (r) => state.copyWith(isSuccess: true, isLoading: false),
        );
        break;
    }
  }
}
