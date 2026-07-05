import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/custom_category.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/models/user_settings.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';

class BackupRestoreService {
  BackupRestoreService({Isar? isar}) : _isar = isar ?? LocalDatabase.instance.isar;

  final Isar _isar;

  /// Exports all collections to a JSON file and presents a share dialog to the user.
  Future<bool> exportBackup() async {
    try {
      // 1. Load data from all collections
      final userSettings = await _isar.userSettings.get(1);
      final subscriptions = await _isar.subscriptionRecords.where().findAll();
      final transactions = await _isar.paymentTransactions.where().findAll();
      final customCategories = await _isar.customCategorys.where().findAll();

      // 2. Build the JSON structure
      final Map<String, dynamic> backupData = {
        'app': 'pay_tempo',
        'version': 1,
        'exportedAt': DateTime.now().toIso8601String(),
        'userSettings': userSettings == null
            ? null
            : {
                'baseCurrency': userSettings.baseCurrency,
                'themeMode': userSettings.themeMode.name,
                'languageCode': userSettings.languageCode,
                'notificationsEnabled': userSettings.notificationsEnabled,
              },
        'subscriptions': subscriptions.map((sub) => {
              'uid': sub.uid,
              'userId': sub.userId,
              'name': sub.name,
              'category': sub.category,
              'note': sub.note,
              'avatarType': sub.avatarType,
              'avatarEmoji': sub.avatarEmoji,
              'avatarIconCodePoint': sub.avatarIconCodePoint,
              'avatarIconFontFamily': sub.avatarIconFontFamily,
              'avatarIconFontPackage': sub.avatarIconFontPackage,
              'avatarColorValue': sub.avatarColorValue,
              'price': sub.price,
              'currency': sub.currency,
              'billingCycle': sub.billingCycle,
              'anchorDay': sub.anchorDay,
              'nextPaymentDate': sub.nextPaymentDate.toIso8601String(),
              'firstPaymentDate': sub.firstPaymentDate?.toIso8601String(),
              'updatedAt': sub.updatedAt.toIso8601String(),
              'isDeleted': sub.isDeleted,
              'enableNotifications': sub.enableNotifications,
            }).toList(),
        'transactions': transactions.map((tx) => {
              'uid': tx.uid,
              'subscriptionUid': tx.subscriptionUid,
              'userId': tx.userId,
              'paidAmount': tx.paidAmount,
              'paidCurrency': tx.paidCurrency,
              'snapshotBaseCurrency': tx.snapshotBaseCurrency,
              'snapshotBaseAmount': tx.snapshotBaseAmount,
              'paidAt': tx.paidAt.toIso8601String(),
              'updatedAt': tx.updatedAt.toIso8601String(),
              'isDeleted': tx.isDeleted,
            }).toList(),
        'customCategories': customCategories.map((cat) => {
              'uid': cat.uid,
              'name': cat.name,
              'iconCodePoint': cat.iconCodePoint,
              'iconFontFamily': cat.iconFontFamily,
              'iconFontPackage': cat.iconFontPackage,
              'updatedAt': cat.updatedAt.toIso8601String(),
              'isDeleted': cat.isDeleted,
            }).toList(),
      };

      // 3. Serialize and write to temporary file
      final String jsonStr = const JsonEncoder.withIndent('  ').convert(backupData);
      final tempDir = await getTemporaryDirectory();
      final String dateStr = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
      final File file = File('${tempDir.path}/paytempo_backup_$dateStr.json');
      await file.writeAsString(jsonStr);

      // 4. Share the file
      // ignore: deprecated_member_use
      final shareResult = await Share.shareXFiles(
        [XFile(file.path, mimeType: 'application/json')],
        subject: 'PayTempo Backup',
      );

      // shareResult.status indicates if it completed or was dismissed
      return shareResult.status == ShareResultStatus.success;
    } catch (_) {
      return false;
    }
  }

  /// Lets the user select a backup JSON file, validates it, and imports it to Isar.
  Future<bool> importBackup() async {
    try {
      // 1. Pick file
      final FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null || result.files.single.path == null) {
        return false;
      }

      // 2. Read and decode contents
      final File file = File(result.files.single.path!);
      final String jsonString = await file.readAsString();
      final Map<String, dynamic> backupData = jsonDecode(jsonString) as Map<String, dynamic>;

      // 3. Validate backup data
      if (backupData['app'] != 'pay_tempo' || backupData['version'] == null) {
        return false;
      }

      // 4. Parse settings
      UserSettings? userSettings;
      if (backupData['userSettings'] != null) {
        final settingsMap = backupData['userSettings'] as Map<String, dynamic>;
        AppThemeMode parsedTheme = AppThemeMode.system;
        try {
          parsedTheme = AppThemeMode.values.byName(settingsMap['themeMode'] as String);
        } catch (_) {}

        userSettings = UserSettings(
          id: 1,
          baseCurrency: (settingsMap['baseCurrency'] as String? ?? 'USD').toUpperCase(),
          themeMode: parsedTheme,
          languageCode: settingsMap['languageCode'] as String?,
          notificationsEnabled: settingsMap['notificationsEnabled'] as bool? ?? true,
        );
      }

      // 5. Parse subscriptions
      final List<SubscriptionRecord> subscriptions = [];
      if (backupData['subscriptions'] != null) {
        for (final item in backupData['subscriptions'] as List) {
          final subMap = item as Map<String, dynamic>;
          subscriptions.add(
            SubscriptionRecord(
              uid: subMap['uid'] as String? ?? '',
              userId: subMap['userId'] as String?,
              name: subMap['name'] as String? ?? '',
              category: subMap['category'] as String? ?? '',
              note: subMap['note'] as String?,
              avatarType: subMap['avatarType'] as String?,
              avatarEmoji: subMap['avatarEmoji'] as String?,
              avatarIconCodePoint: subMap['avatarIconCodePoint'] as int?,
              avatarIconFontFamily: subMap['avatarIconFontFamily'] as String?,
              avatarIconFontPackage: subMap['avatarIconFontPackage'] as String?,
              avatarColorValue: subMap['avatarColorValue'] as int?,
              price: (subMap['price'] as num? ?? 0.0).toDouble(),
              currency: subMap['currency'] as String? ?? 'USD',
              billingCycle: subMap['billingCycle'] as String? ?? 'monthly',
              anchorDay: subMap['anchorDay'] as int? ?? 1,
              nextPaymentDate: DateTime.parse(subMap['nextPaymentDate'] as String),
              firstPaymentDate: subMap['firstPaymentDate'] != null
                  ? DateTime.parse(subMap['firstPaymentDate'] as String)
                  : null,
              updatedAt: DateTime.parse(subMap['updatedAt'] as String),
              isDeleted: subMap['isDeleted'] as bool? ?? false,
              enableNotifications: subMap['enableNotifications'] as bool? ?? true,
            ),
          );
        }
      }

      // 6. Parse transactions
      final List<PaymentTransaction> transactions = [];
      if (backupData['transactions'] != null) {
        for (final item in backupData['transactions'] as List) {
          final txMap = item as Map<String, dynamic>;
          transactions.add(
            PaymentTransaction(
              uid: txMap['uid'] as String? ?? '',
              subscriptionUid: txMap['subscriptionUid'] as String? ?? '',
              userId: txMap['userId'] as String?,
              paidAmount: (txMap['paidAmount'] as num? ?? 0.0).toDouble(),
              paidCurrency: txMap['paidCurrency'] as String? ?? 'USD',
              snapshotBaseCurrency: txMap['snapshotBaseCurrency'] as String? ?? 'USD',
              snapshotBaseAmount: (txMap['snapshotBaseAmount'] as num? ?? 0.0).toDouble(),
              paidAt: DateTime.parse(txMap['paidAt'] as String),
              updatedAt: DateTime.parse(txMap['updatedAt'] as String),
              isDeleted: txMap['isDeleted'] as bool? ?? false,
            ),
          );
        }
      }

      // 7. Parse custom categories
      final List<CustomCategory> customCategories = [];
      if (backupData['customCategories'] != null) {
        for (final item in backupData['customCategories'] as List) {
          final catMap = item as Map<String, dynamic>;
          customCategories.add(
            CustomCategory(
              uid: catMap['uid'] as String? ?? '',
              name: catMap['name'] as String? ?? '',
              iconCodePoint: catMap['iconCodePoint'] as int? ?? 0,
              iconFontFamily: catMap['iconFontFamily'] as String?,
              iconFontPackage: catMap['iconFontPackage'] as String?,
              updatedAt: DateTime.parse(catMap['updatedAt'] as String),
              isDeleted: catMap['isDeleted'] as bool? ?? false,
            ),
          );
        }
      }

      // 8. Perform Isar write transaction to restore database state
      await _isar.writeTxn(() async {
        await _isar.userSettings.clear();
        await _isar.subscriptionRecords.clear();
        await _isar.paymentTransactions.clear();
        await _isar.customCategorys.clear();

        if (userSettings != null) {
          await _isar.userSettings.put(userSettings);
        }
        await _isar.subscriptionRecords.putAll(subscriptions);
        await _isar.paymentTransactions.putAll(transactions);
        await _isar.customCategorys.putAll(customCategories);
      });

      // 9. Force reinitialize state notifiers to reflect the restored database settings
      await UserSettingsService().initializeSettings();

      return true;
    } catch (_) {
      return false;
    }
  }
}
