import 'package:freezed_annotation/freezed_annotation.dart';

part 'favourite_creation.freezed.dart';

@freezed
abstract class FavouriteCreation with _$FavouriteCreation{
  factory FavouriteCreation({
    required double lat,
    required double lon,
    required String title,
  }) = _FavouriteCreation;
}