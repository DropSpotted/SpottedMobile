class GeoError<T> {
  const GeoError({
    // required this.message,
    required this.code,
  });

  /// Unique error code
  final T code;

  // /// Complete error message.
  // final String message;
}
