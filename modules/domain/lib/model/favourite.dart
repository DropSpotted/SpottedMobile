import 'dart:typed_data';

import 'package:domain/model/point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favourite.freezed.dart';

@freezed
abstract class Favourite with _$Favourite {
  factory Favourite({
    required String id,
    required Point geoLocationCoords,
    required String title,
    required DateTime createdAt,
    @Default('') String place,
    Uint8List? iOSImage,
  }) = _Favourite;
}