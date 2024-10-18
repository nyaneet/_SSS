import 'package:sss/presentation/core/models/extentions/strings.dart';

extension DateTimeExt on DateTime {
  /// Returns [DateTime] in format 'dd.mm.yy hh:mm'
  String formatRU() {
    return '${'$day'.padNumber()}.${'$month'.padNumber()}.${'$year'.substring(2)} ${'$hour'.padNumber()}:${'$minute'.padNumber()}';
  }
}
