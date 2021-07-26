import 'package:freezed_annotation/freezed_annotation.dart';

part 'favourite_update.freezed.dart';

@freezed
abstract class FavouriteUpdate with _$FavouriteUpdate {
  factory FavouriteUpdate({
    String? title,
  }) = _FavouriteUpdate;
}
