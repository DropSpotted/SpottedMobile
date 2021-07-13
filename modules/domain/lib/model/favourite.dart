import 'package:freezed_annotation/freezed_annotation.dart';

part 'favourite.freezed.dart';

@freezed
abstract class Favourite with _$Favourite {
  factory Favourite({
    required String id,
    required double lat,
    required double lon,
    required String title,
    required DateTime createdAt,
  }) = _Favourite;
}