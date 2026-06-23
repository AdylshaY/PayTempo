import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  /// Format: e.g. "15 Jan 2026"
  String toFullDateLabel([String? locale]) {
    // In Turkish, yMMMd formats as "15 Oca 2026". In English, it formats as "Jan 15, 2026" (or similar).
    return DateFormat.yMMMd(locale).format(this);
  }

  /// Format: e.g. "Jan 15"
  String toMonthDayLabel([String? locale]) {
    return DateFormat.MMMd(locale).format(this);
  }

  /// Format: e.g. "Jan 2026"
  String toMonthYearLabel([String? locale]) {
    return DateFormat.yMMM(locale).format(this);
  }

  /// Format: e.g. "Jan 15, 2026"
  String toMonthDayYearCommaLabel([String? locale]) {
    return DateFormat.yMMMd(locale).format(this);
  }
}
