const List<String> _monthLabels = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

extension DateFormatter on DateTime {
  /// Format: "15 Jan 2026"
  String toFullDateLabel() {
    return '$day ${_monthLabels[month - 1]} $year';
  }

  /// Format: "Jan 15"
  String toMonthDayLabel() {
    return '${_monthLabels[month - 1]} $day';
  }

  /// Format: "Jan 2026"
  String toMonthYearLabel() {
    return '${_monthLabels[month - 1]} $year';
  }

  /// Format: "Jan 15, 2026"
  String toMonthDayYearCommaLabel() {
    return '${_monthLabels[month - 1]} $day, $year';
  }
}
