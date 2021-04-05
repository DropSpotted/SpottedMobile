import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/model/post.dart';
import 'package:domain/service/post/post_service.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';
part 'dashboard_bloc.freezed.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({
    required PostService postService,
  })   : _postService = postService,
        super(DashboardState.initial());

  final PostService _postService;

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    yield* event.map(
      started: _mapStartedToState,
    );
  }

  Stream<DashboardState> _mapStartedToState(_Started event) async* {
    yield state.copyWith(isLoading: true);
    final response = await _postService.postList(10.0, 10.0);

    yield response.fold(
      (l) => state.copyWith(isLoading: false),
      (post) => state.copyWith(
        isLoading: false,
        posts: post,
      ),
    );
  }
}
