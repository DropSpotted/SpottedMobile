part of 'post_creation_bloc.dart';

@freezed
class PostCreationEvent with _$PostCreationEvent {
  const factory PostCreationEvent.typed(String text) = _Typed;
  const factory PostCreationEvent.submitted(double lat, double lon) = _Submitted;
}