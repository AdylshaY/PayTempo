import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:subscription_tracker/data/local/models/payment_transaction.dart';
import 'package:subscription_tracker/data/local/models/subscription_record.dart';
import 'package:subscription_tracker/data/local/models/user_settings.dart';

class LocalDatabase {
  LocalDatabase._();

  static final LocalDatabase instance = LocalDatabase._();

  Isar? _isar;

  Future<Isar> open() async {
    final Isar? existing = _isar;
    if (existing != null && existing.isOpen) {
      return existing;
    }

    final appSupportDir = await getApplicationSupportDirectory();
    final opened = await Isar.open(
      <CollectionSchema<Object>>[
        UserSettingsSchema,
        SubscriptionRecordSchema,
        PaymentTransactionSchema,
      ],
      directory: appSupportDir.path,
      name: 'paytempo',
    );

    _isar = opened;
    return opened;
  }

  Isar get isar {
    final Isar? db = _isar;
    if (db == null || !db.isOpen) {
      throw StateError('Isar is not initialized. Call LocalDatabase.instance.open() first.');
    }
    return db;
  }

  Future<void> close() async {
    final Isar? db = _isar;
    if (db != null && db.isOpen) {
      await db.close();
    }
    _isar = null;
  }
}
