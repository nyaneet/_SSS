import 'package:sss/presentation/core/models/extentions/strings.dart';

extension DateTimeExt on DateTime {
  ///
  /// Formats the [DateTime] into a 'dd.mm.yy hh:mm tz' string.
  /// The timezone is set to local zone.
  String formatRU() {
    final date = toLocal();
    final tz =
        '${date.timeZoneOffset.isNegative ? '' : '+'}${date.timeZoneOffset.inHours}';
    return '${'$day'.padNumber()}.${'$month'.padNumber()}.${'$year'.substring(2)} ${'$hour'.padNumber()}:${'$minute'.padNumber()} $tz';
  }
}
