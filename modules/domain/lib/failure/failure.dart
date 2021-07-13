import 'package:domain/failure/error_body.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
abstract class Failure<T> with _$Failure {
  const factory Failure.errorBody(ErrorBody<T> error) = _ErrorBody;
  const factory Failure.unexpected() = _Unexpected;
  const factory Failure.connectTimeout() = _ConnectTimeout;
  const factory Failure.sendTimeout() = _SendTimeout;
  const factory Failure.receiveTimeout() = _ReceiveTimeout;
  const factory Failure.cancel() = _Cancel;
  const factory Failure.defaultType() = _DefaultType;
}