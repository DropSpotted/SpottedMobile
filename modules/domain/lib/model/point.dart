import 'package:freezed_annotation/freezed_annotation.dart';

part 'point.freezed.dart';

@freezed
abstract class Point with _$Point {
  factory Point({
    required String type,
    required List<double> coordinates,
  }) = _Point;
}