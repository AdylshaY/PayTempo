import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// Fetches and caches exchange rates from the Frankfurter API.
///
/// Rates are cached as a JSON file in the app's support directory.
/// When offline, the last successfully cached rates are used.
/// If no cache exists, conversions fall back to 1:1 (no conversion).
class ExchangeRateService {
  ExchangeRateService._();

  static final ExchangeRateService instance = ExchangeRateService._();

  static final ValueNotifier<bool> isOfflineNotifier = ValueNotifier<bool>(false);
  static final ValueNotifier<DateTime?> lastUpdateNotifier = ValueNotifier<DateTime?>(null);

  static const String _apiBaseUrl = 'https://api.frankfurter.app';
  static const String _cacheFileName = 'exchange_rates_cache.json';

  /// In-memory rate map: currency code → rate relative to the base currency.
  /// Example for base=TRY: { "USD": 0.029, "EUR": 0.026, "TRY": 1.0 }
  Map<String, double> _rates = <String, double>{};

  /// The base currency these rates are relative to.
  String? _baseCurrency;

  /// Fetches the latest rates from Frankfurter and caches them locally.
  ///
  /// This method is safe to call even without internet — it will silently
  /// fall back to the existing cache. If no cache exists either, rates
  /// remain empty and [convert] returns the original amount (1:1 fallback).
  Future<void> fetchAndCacheRates(String baseCurrency) async {
    final String normalized = baseCurrency.trim().toUpperCase();
    
    // Check if cache file exists and was modified within the last hour
    try {
      final File file = await _cacheFile();
      if (file.existsSync()) {
        final DateTime lastModified = file.lastModifiedSync();
        final Duration difference = DateTime.now().difference(lastModified);
        if (difference.inHours < 1) {
          await _loadCacheFromDisk();
          if (_baseCurrency == normalized && _rates.isNotEmpty) {
            return; // Cache is fresh and base currency matches, skip fetch.
          }
        }
      }
    } catch (_) {
      // Ignore cache check errors, proceed to normal fetch.
    }

    _baseCurrency = normalized;

    // Try loading from cache first so we always have something.
    await _loadCacheFromDisk();

    try {
      final Uri uri = Uri.parse('$_apiBaseUrl/latest?base=$normalized');
      final http.Response response = await http
          .get(uri)
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final Map<String, dynamic> json =
            jsonDecode(response.body) as Map<String, dynamic>;
        final Map<String, dynamic> ratesJson =
            json['rates'] as Map<String, dynamic>? ?? <String, dynamic>{};

        _rates = <String, double>{
          normalized: 1.0,
          for (final MapEntry<String, dynamic> entry in ratesJson.entries)
            entry.key.toUpperCase(): (entry.value as num).toDouble(),
        };

        await _saveCacheToDisk(response.body);
        isOfflineNotifier.value = false;
        lastUpdateNotifier.value = DateTime.now();
      } else {
        isOfflineNotifier.value = true;
      }
    } on SocketException {
      isOfflineNotifier.value = true;
    } on HttpException {
      isOfflineNotifier.value = true;
    } on FormatException {
      isOfflineNotifier.value = true;
    } catch (_) {
      isOfflineNotifier.value = true;
    }
  }

  /// Converts [amount] from [fromCurrency] to [toCurrency] using cached rates.
  ///
  /// If both currencies are the same, returns [amount] unchanged.
  /// If a rate is unavailable (no cache, unsupported currency), returns
  /// [amount] unchanged (1:1 fallback) to avoid blocking the user.
  double convert(double amount, String fromCurrency, String toCurrency) {
    final String from = fromCurrency.trim().toUpperCase();
    final String to = toCurrency.trim().toUpperCase();

    if (from == to) {
      return amount;
    }

    if (_rates.isEmpty || _baseCurrency == null) {
      return amount;
    }

    // Rates are relative to _baseCurrency.
    // To convert from A to B: amount * (rate_B / rate_A).
    final double? fromRate = _rates[from];
    final double? toRate = _rates[to];

    if (fromRate == null || toRate == null || fromRate == 0) {
      return amount;
    }

    return amount * (toRate / fromRate);
  }

  /// Returns the exchange rate from [fromCurrency] to [toCurrency],
  /// or `null` if the rate is unavailable.
  double? getRate(String fromCurrency, String toCurrency) {
    final String from = fromCurrency.trim().toUpperCase();
    final String to = toCurrency.trim().toUpperCase();

    if (from == to) {
      return 1.0;
    }

    if (_rates.isEmpty || _baseCurrency == null) {
      return null;
    }

    final double? fromRate = _rates[from];
    final double? toRate = _rates[to];

    if (fromRate == null || toRate == null || fromRate == 0) {
      return null;
    }

    return toRate / fromRate;
  }

  /// Fetches the exchange rate for a specific historical [date].
  ///
  /// Uses Frankfurter's historical endpoint: `GET /{date}?base=X&symbols=Y`.
  /// Returns the rate, or `null` if the request fails or the pair is
  /// unsupported. Falls back to the current cached rate as a last resort.
  Future<double?> fetchHistoricalRate({
    required DateTime date,
    required String fromCurrency,
    required String toCurrency,
  }) async {
    final String from = fromCurrency.trim().toUpperCase();
    final String to = toCurrency.trim().toUpperCase();

    if (from == to) {
      return 1.0;
    }

    final String dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    try {
      final Uri uri =
          Uri.parse('$_apiBaseUrl/$dateStr?base=$from&symbols=$to');
      final http.Response response = await http
          .get(uri)
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final Map<String, dynamic> json =
            jsonDecode(response.body) as Map<String, dynamic>;
        final Map<String, dynamic> ratesJson =
            json['rates'] as Map<String, dynamic>? ?? <String, dynamic>{};
        final num? rate = ratesJson[to] as num?;
        if (rate != null) {
          return rate.toDouble();
        }
      }
    } catch (_) {
      // Network or parse error — fall through to cached rate.
    }

    // Fallback: use current cached rate if available.
    return getRate(from, to);
  }

  // ---------------------------------------------------------------------------
  // Cache helpers
  // ---------------------------------------------------------------------------

  Future<File> _cacheFile() async {
    final Directory dir = await getApplicationSupportDirectory();
    return File('${dir.path}/$_cacheFileName');
  }

  Future<void> _loadCacheFromDisk() async {
    try {
      final File file = await _cacheFile();
      if (!file.existsSync()) {
        return;
      }

      final lastModified = file.lastModifiedSync();
      lastUpdateNotifier.value = lastModified;

      final String contents = await file.readAsString();
      final Map<String, dynamic> json =
          jsonDecode(contents) as Map<String, dynamic>;
      final Map<String, dynamic> ratesJson =
          json['rates'] as Map<String, dynamic>? ?? <String, dynamic>{};
      final String? cachedBase = json['base'] as String?;

      if (ratesJson.isNotEmpty) {
        _rates = <String, double>{
          if (cachedBase != null) cachedBase.toUpperCase(): 1.0,
          for (final MapEntry<String, dynamic> entry in ratesJson.entries)
            entry.key.toUpperCase(): (entry.value as num).toDouble(),
        };
      }
    } catch (_) {
      // Cache corrupted or unreadable — continue without rates.
    }
  }

  Future<void> _saveCacheToDisk(String jsonBody) async {
    try {
      final File file = await _cacheFile();
      await file.writeAsString(jsonBody);
    } catch (_) {
      // Failed to write cache — non-critical, ignore.
    }
  }
}
