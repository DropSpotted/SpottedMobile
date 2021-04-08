import 'package:timeago/timeago.dart' as timeago;

extension DateTimeExtension on DateTime {
  String get toTimaAgo {
    final duration = DateTime.now().difference(this);
    final dateTime = DateTime.now().subtract(duration);

    return timeago.format(dateTime);
  }
}
