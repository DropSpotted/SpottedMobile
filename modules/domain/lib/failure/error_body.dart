import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_body.freezed.dart';

@freezed
class ErrorBody<T> with _$ErrorBody {
  const factory ErrorBody({
    T? data,
    int? errorCode,
  }) = _ErrorBody;
}
