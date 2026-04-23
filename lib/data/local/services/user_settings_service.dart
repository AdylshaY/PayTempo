import 'package:isar/isar.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';

class UserSettingsService {
  UserSettingsService({Isar? isar}) : _isar = isar ?? LocalDatabase.instance.isar;

  final Isar _isar;

  Future<UserSettings?> getSettings() {
    return _isar.userSettings.get(1);
  }

  Future<bool> hasBaseCurrency() async {
    final UserSettings? settings = await getSettings();
    final String? currency = settings?.baseCurrency;
    if (currency == null) {
      return false;
    }
    return currency.trim().isNotEmpty;
  }

  Future<void> saveBaseCurrency(String baseCurrency) async {
    final String normalized = baseCurrency.trim().toUpperCase();

    await _isar.writeTxn(() async {
      final UserSettings? current = await _isar.userSettings.get(1);
      if (current == null) {
        await _isar.userSettings.put(
          UserSettings(baseCurrency: normalized),
        );
        return;
      }

      final String existing = current.baseCurrency.trim().toUpperCase();
      if (existing.isNotEmpty && existing != normalized) {
        throw StateError('Base currency cannot be changed after onboarding.');
      }

      if (existing.isEmpty) {
        current.baseCurrency = normalized;
        await _isar.userSettings.put(current);
      }
    });
  }

  Future<void> setProStatus({
    required bool isPro,
    String? userId,
  }) async {
    await _isar.writeTxn(() async {
      final UserSettings? current = await _isar.userSettings.get(1);
      if (current == null) {
        throw StateError('UserSettings not found. Save base currency first.');
      }

      current.isPro = isPro;
      current.userId = userId;
      current.lastSyncTime = DateTime.now();
      await _isar.userSettings.put(current);
    });
  }
}
