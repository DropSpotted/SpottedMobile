import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/post_creation.dart';
import 'package:domain/service/comment/comment_service.dart';
import 'package:domain/service/post/post_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geo/error/error_code.dart';
import 'package:spotted/common/bloc/geo_manager/geo_manager_cubit.dart';
import 'package:spotted/common/formz/post_formz.dart';
import 'package:spotted/pages/post_creation/post_creation_arguments.dart';

part 'post_creation_state.dart';
part 'post_creation_cubit.freezed.dart';

class PostCreationCubit extends Cubit<PostCreationState> {
  PostCreationCubit({
    required PostService postService,
    required CommentService commentService,
    required PostCreationArguments postCreationArguments,
    required GeoManagerCubit geoManagerCubit,
  })  : _postService = postService,
        _commentService = commentService,
        _geoManagerCubit = geoManagerCubit,
        super(PostCreationState.initial(
          creationType: postCreationArguments.creationType,
          parentPostId: postCreationArguments.parentPostId,
        ));

  final PostService _postService;
  final CommentService _commentService;
  final GeoManagerCubit _geoManagerCubit;

  void typed(String value) => emit(
        state.copyWith(
          postInput: PostInput.dirty(
            value: value,
          ),
        ),
      );

  Future<void> valueSubmitted() async {
    emit(state.copyWith(isLoading: true));

    _geoManagerCubit.stream.where((event) => event is! GeoManagerInitial).take(1).listen((event) {
      _mapGeoManagerState(event);
    });

    await _geoManagerCubit.askCurrentLocation();
  }

  Future<void> _mapGeoManagerState(GeoManagerState geoManagerState) async {
    final newState = await geoManagerState.map(
      initial: (geoState) async => state,
      load: (geoState) async {
        switch (state.creationType) {
          case CreationType.post:
            final createdPostResponse = await _postService.createPost(
              PostCreation(
                body: state.postInput.value,
                lat: geoState.geoPosition.latitude,
                lon: geoState.geoPosition.longitude,
              ),
            );

            return createdPostResponse.fold((failure) {
              return state.copyWith(failureOrSuccess: optionOf(left(failure)));
            }, (result) {
              return state.copyWith(failureOrSuccess: optionOf(right(unit)));
            });

          case CreationType.comment:
            final createdCommentResponse = await _commentService.createComment(
              state.parentPostId ?? '',
              state.postInput.value,
            );

            return createdCommentResponse.fold(
              (failure) => state.copyWith(failureOrSuccess: optionOf(left(failure))),
              (result) => state.copyWith(failureOrSuccess: optionOf(right(unit))),
            );
        }
      },
      failure: (geoErrorCode) async => state.copyWith(
        geoErrorCode: optionOf(geoErrorCode.geoError),
      ),
    );

    emit(newState.copyWith(isLoading: false));
  }
}
