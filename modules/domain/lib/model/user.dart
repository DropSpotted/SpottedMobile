
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  factory User({
    required String id,
    required String username,
    required DateTime dateCreated,
    required String biographicEntry,
  }) = _User;
}