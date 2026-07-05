import 'package:intl/intl.dart';

class CurrencyFormatter {
  // Map to resolve language/locale mapping for major currencies.
  static String _getLocale(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'TRY':
        return 'tr_TR';
      case 'USD':
        return 'en_US';
      case 'EUR':
        return 'de_DE'; // European format (1.234,56 €)
      case 'GBP':
        return 'en_GB';
      case 'JPY':
        return 'ja_JP';
      case 'CNY':
        return 'zh_CN';
      case 'CAD':
        return 'en_CA';
      case 'AUD':
        return 'en_AU';
      case 'CHF':
        return 'de_CH';
      default:
        return 'en_US';
    }
  }

  static int _getDecimalDigits(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'JPY':
      case 'KRW':
        return 0;
      default:
        return 2;
    }
  }

  /// Formats the [amount] according to the [currencyCode] standard styling.
  /// Example: format(1234.56, 'TRY') -> "1.234,56 ₺"
  /// Example: format(1234.56, 'USD') -> "$ 1,234.56"
  static String format(double amount, String currencyCode) {
    final locale = _getLocale(currencyCode);
    final decimalDigits = _getDecimalDigits(currencyCode);
    
    final formatter = NumberFormat.currency(
      locale: locale,
      name: currencyCode.toUpperCase(),
      decimalDigits: decimalDigits,
    );
    
    final formatted = formatter.format(amount);
    return _addSpaceToSymbol(formatted);
  }

  /// Formats the [amount] compactly (rounded to integer, but still formatted nicely).
  /// If the currency has 0 decimal digits originally, it behaves identically to [format].
  static String formatCompact(double amount, String currencyCode) {
    final locale = _getLocale(currencyCode);
    final formatter = NumberFormat.currency(
      locale: locale,
      name: currencyCode.toUpperCase(),
      decimalDigits: 0,
    );
    
    final formatted = formatter.format(amount);
    return _addSpaceToSymbol(formatted);
  }

  /// Helper to insert a space between a currency symbol and the number digits.
  static String _addSpaceToSymbol(String formatted) {
    // If it starts with a non-digit, non-space character (symbol) followed by a digit
    // e.g. "$1,200.00" -> "$ 1,200.00" or "TRY1,200.00" -> "TRY 1,200.00"
    final startMatch = RegExp(r'^([^\d\s\-\+,.]+)([\d\-+])');
    if (startMatch.hasMatch(formatted)) {
      return formatted.replaceFirstMapped(startMatch, (match) => '${match.group(1)} ${match.group(2)}');
    }

    // If it ends with a non-digit, non-space character (symbol) preceded by a digit
    // e.g. "1.200,00₺" -> "1.200,00 ₺"
    final endMatch = RegExp(r'([\d])([^\d\s\-\+,.]+)$');
    if (endMatch.hasMatch(formatted)) {
      return formatted.replaceFirstMapped(endMatch, (match) => '${match.group(1)} ${match.group(2)}');
    }

    return formatted;
  }
}
