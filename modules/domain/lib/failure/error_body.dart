class ErrorBody<T> {
  const ErrorBody({
    this.data,
    this.errorCode,
  });

  final T? data;
  final int? errorCode;
}
