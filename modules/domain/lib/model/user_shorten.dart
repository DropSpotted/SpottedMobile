import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_shorten.freezed.dart';

@freezed
abstract class UserShorten with _$UserShorten {
  factory UserShorten({
    String? id,
    String? username,
  }) = _UserShorten;
}
