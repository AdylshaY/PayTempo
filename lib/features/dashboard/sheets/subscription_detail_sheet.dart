import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/date_formatter.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/payment_transaction.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/models/notification_reminder.dart';
import 'package:pay_tempo/data/local/services/exchange_rate_service.dart';
import 'package:pay_tempo/features/dashboard/widgets/subscription_share_card.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_categories.dart';
import 'package:pay_tempo/data/local/services/notification_service.dart';
import 'package:pay_tempo/app/widgets/subscription_avatar_widget.dart';
import 'package:pay_tempo/app/utils/subscription_helpers.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

/// A bottom sheet that displays full details for a subscription,
/// including recent payment history and a converted price equivalent.
class SubscriptionDetailSheet extends StatefulWidget {
  const SubscriptionDetailSheet({
    required this.subscription,
    required this.baseCurrency,
    this.isPaidThisMonth = false,
    this.onMarkPaid,
    super.key,
  });

  final SubscriptionRecord subscription;
  final String baseCurrency;
  final bool isPaidThisMonth;
  final VoidCallback? onMarkPaid;

  @override
  State<SubscriptionDetailSheet> createState() => _SubscriptionDetailSheetState();
}

class _SubscriptionDetailSheetState extends State<SubscriptionDetailSheet> {
  late bool _notificationsEnabled;
  final GlobalKey _shareKey = GlobalKey();
  List<NotificationReminder> _reminders = [];

  @override
  void initState() {
    super.initState();
    _notificationsEnabled = widget.subscription.enableNotifications;
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final isar = LocalDatabase.instance.isar;
    final List<NotificationReminder> list = await isar.notificationReminders
        .filter()
        .subscriptionUidEqualTo(widget.subscription.uid)
        .findAll();
    setState(() {
      _reminders = list;
    });
  }

  Future<void> _shareSubscription() async {
    HapticFeedback.mediumImpact();
    final l10n = AppLocalizations.of(context)!;
    final subscription = widget.subscription;
    final baseCurrency = widget.baseCurrency;

    final bool showConversion =
        subscription.currency.toUpperCase() != baseCurrency.toUpperCase();

    final double basePrice = ExchangeRateService.instance.convert(
      subscription.price,
      subscription.currency,
      baseCurrency,
    );

    final String cycle = billingCycleLabel(subscription.billingCycle, l10n);

    final StringBuffer buffer = StringBuffer();
    buffer.writeln('📋 ${subscription.name} — ${l10n.subscriptionManageTitle}');
    buffer.writeln('💵 ${l10n.priceLabel}: ${subscription.price.toStringAsFixed(2)} ${subscription.currency} ($cycle)');

    if (showConversion) {
      buffer.writeln('🔄 ${l10n.equivalentLabel}: ≈ ${basePrice.toStringAsFixed(2)} $baseCurrency');
    }

    buffer.writeln('📅 ${l10n.nextPaymentLabel}: ${subscription.nextPaymentDate.toMonthDayYearCommaLabel(l10n.localeName)}');

    if (subscription.note != null && subscription.note!.isNotEmpty) {
      buffer.writeln('📝 ${l10n.noteLabel}: ${subscription.note}');
    }

    buffer.writeln();
    buffer.write('Tracked via PayTempo ⚡');

    try {
      final RenderRepaintBoundary? boundary =
          _shareKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary != null) {
        // High resolution capture
        final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        final ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData != null) {
          final Uint8List pngBytes = byteData.buffer.asUint8List();
          final Directory tempDir = await getTemporaryDirectory();
          final String safeName = subscription.name.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
          final String path = '${tempDir.path}/paytempo_$safeName.png';
          final File file = File(path);
          await file.writeAsBytes(pngBytes);

          // ignore: deprecated_member_use
          await Share.shareXFiles(
            [XFile(path)],
            subject: subscription.name,
          );
          return;
        }
      }
    } catch (e) {
      debugPrint('Error sharing subscription card image, falling back to text: $e');
    }

    // Fallback to text sharing if image rendering or writing fails
    // ignore: deprecated_member_use
    await Share.share(buffer.toString(), subject: subscription.name);
  }

  Future<void> _toggleNotifications(bool value) async {
    setState(() {
      _notificationsEnabled = value;
    });

    final isar = LocalDatabase.instance.isar;
    await isar.writeTxn(() async {
      widget.subscription.enableNotifications = value;
      widget.subscription.updatedAt = DateTime.now();
      await isar.subscriptionRecords.put(widget.subscription);
    });

    if (value) {
      await NotificationService.instance.scheduleSubscriptionNotifications(widget.subscription);
      await _loadReminders();
    } else {
      await NotificationService.instance.cancelSubscriptionNotifications(widget.subscription);
    }
  }

  Future<void> _toggleReminderDay(int daysBefore) async {
    HapticFeedback.lightImpact();
    final isar = LocalDatabase.instance.isar;
    final bool currentlySelected = _reminders.any((r) => r.daysBefore == daysBefore);

    if (currentlySelected) {
      if (_reminders.length == 1) {
        // Last reminder removed -> disable notifications completely
        await _toggleNotifications(false);
        return;
      }

      final reminderToRemove = _reminders.firstWhere((r) => r.daysBefore == daysBefore);
      await isar.writeTxn(() async {
        await isar.notificationReminders.delete(reminderToRemove.id);
      });
      setState(() {
        _reminders.removeWhere((r) => r.daysBefore == daysBefore);
      });
    } else {
      final newReminder = NotificationReminder(
        uid: '${DateTime.now().microsecondsSinceEpoch}_${daysBefore}_${widget.subscription.uid}',
        subscriptionUid: widget.subscription.uid,
        daysBefore: daysBefore,
        updatedAt: DateTime.now(),
      );

      await isar.writeTxn(() async {
        await isar.notificationReminders.put(newReminder);
      });

      setState(() {
        _reminders.add(newReminder);
      });
    }

    await NotificationService.instance.scheduleSubscriptionNotifications(widget.subscription);
  }

  Future<void> _updateReminderTime(NotificationReminder reminder, int? hour, int? minute) async {
    final isar = LocalDatabase.instance.isar;
    await isar.writeTxn(() async {
      reminder.customHour = hour;
      reminder.customMinute = minute;
      reminder.updatedAt = DateTime.now();
      await isar.notificationReminders.put(reminder);
    });

    await _loadReminders();
    await NotificationService.instance.scheduleSubscriptionNotifications(widget.subscription);
  }

  Widget _buildReminderChip(int day, AppLocalizations l10n, TextTheme textTheme) {
    NotificationReminder? reminder;
    for (final r in _reminders) {
      if (r.daysBefore == day) {
        reminder = r;
        break;
      }
    }
    final bool isSelected = reminder != null;

    String label;
    if (day == 0) {
      label = l10n.reminderSameDay;
    } else if (day == 1) {
      label = l10n.reminder1DayBefore;
    } else if (day == 2) {
      label = l10n.reminder2DaysBefore;
    } else if (day == 3) {
      label = l10n.reminder3DaysBefore;
    } else {
      label = l10n.reminder7DaysBefore;
    }

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color backgroundColor = isSelected
        ? colorScheme.primary
        : (Theme.of(context).brightness == Brightness.dark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.05));

    final Color foregroundColor = isSelected
        ? colorScheme.onPrimary
        : colorScheme.onSurface;

    final int globalHour = UserSettingsService.notificationHourNotifier.value;
    final int globalMinute = UserSettingsService.notificationMinuteNotifier.value;

    final int displayHour = reminder?.customHour ?? globalHour;
    final int displayMinute = reminder?.customMinute ?? globalMinute;
    final bool hasCustomTime = reminder?.customHour != null && reminder?.customMinute != null;

    final String timeStr =
        '${displayHour.toString().padLeft(2, '0')}:${displayMinute.toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadii.button),
        border: Border.all(
          color: isSelected
              ? colorScheme.primary
              : (Theme.of(context).brightness == Brightness.dark
                  ? AppColors.inactiveDark
                  : AppColors.inactive),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => _toggleReminderDay(day),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(AppRadii.button - 1),
              bottomLeft: const Radius.circular(AppRadii.button - 1),
              topRight: isSelected ? Radius.zero : const Radius.circular(AppRadii.button - 1),
              bottomRight: isSelected ? Radius.zero : const Radius.circular(AppRadii.button - 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 8),
              child: Text(
                label,
                style: textTheme.bodySmall?.copyWith(
                  color: foregroundColor,
                  fontWeight: isSelected ? FontWeight.w600 : null,
                ),
              ),
            ),
          ),
          if (isSelected) ...[
            Container(
              width: 1,
              height: 20,
              color: foregroundColor.withValues(alpha: 0.3),
            ),
            InkWell(
              onTap: () async {
                HapticFeedback.lightImpact();
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(hour: displayHour, minute: displayMinute),
                );
                if (picked != null) {
                  await _updateReminderTime(reminder!, picked.hour, picked.minute);
                }
              },
              borderRadius: BorderRadius.only(
                topRight: const Radius.circular(AppRadii.button - 1),
                bottomRight: const Radius.circular(AppRadii.button - 1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time_filled_rounded,
                      size: 14,
                      color: foregroundColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeStr,
                      style: textTheme.bodySmall?.copyWith(
                        color: foregroundColor,
                        fontWeight: isSelected ? FontWeight.w600 : null,
                        fontStyle: hasCustomTime ? null : FontStyle.italic,
                      ),
                    ),
                    if (hasCustomTime) ...[
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () async {
                          HapticFeedback.lightImpact();
                          await _updateReminderTime(reminder!, null, null);
                        },
                        child: Icon(
                          Icons.close_rounded,
                          size: 12,
                          color: foregroundColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final subscription = widget.subscription;
    final baseCurrency = widget.baseCurrency;
    final isPaidThisMonth = widget.isPaidThisMonth;
    final onMarkPaid = widget.onMarkPaid;

    final TextTheme textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    final bool showConversion =
        subscription.currency.toUpperCase() != baseCurrency.toUpperCase();

    return Stack(
      children: [
        Positioned(
          left: -9999,
          top: -9999,
          child: RepaintBoundary(
            key: _shareKey,
            child: SubscriptionShareCard(
              subscription: subscription,
              baseCurrency: baseCurrency,
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              0,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Header ──
                Row(
                  children: [
                    SubscriptionAvatarWidget(
                      item: subscription,
                      size: 56,
                      borderRadius: AppRadii.card,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subscription.name,
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                getCategoryLabel(subscription.category, l10n),
                                style: textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              if (subscription.note != null &&
                                  subscription.note!.isNotEmpty) ...[
                                Text(
                                  ' • ',
                                  style: textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    subscription.note!,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share_rounded),
                      tooltip: l10n.shareSubscription,
                      onPressed: _shareSubscription,
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.md),

                // ── Info Grid ──
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Column(
                      children: [
                        _InfoRow(
                          icon: Icons.payments_outlined,
                          label: l10n.priceLabel,
                          value:
                              '${subscription.price.toStringAsFixed(2)} ${subscription.currency}',
                        ),
                        if (showConversion) ...[
                          const SizedBox(height: AppSpacing.xs),
                          _InfoRow(
                            icon: Icons.currency_exchange,
                            label: l10n.equivalentLabel,
                            value:
                                '≈ ${ExchangeRateService.instance.convert(subscription.price, subscription.currency, baseCurrency).toStringAsFixed(2)} $baseCurrency',
                          ),
                        ],
                        const SizedBox(height: AppSpacing.xs),
                        _InfoRow(
                          icon: Icons.repeat,
                          label: l10n.billingCycleLabel,
                          value: billingCycleLabel(subscription.billingCycle, l10n),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        _InfoRow(
                          icon: Icons.calendar_today_outlined,
                          label: l10n.nextPaymentLabel,
                          value: subscription.nextPaymentDate
                              .toMonthDayYearCommaLabel(l10n.localeName),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        _InfoRow(
                          icon: Icons.pin_outlined,
                          label: l10n.anchorDayLabel,
                          value: '${subscription.anchorDay}',
                        ),
                        const Divider(height: AppSpacing.md),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          secondary: Icon(
                            _notificationsEnabled
                                ? Icons.notifications_active_outlined
                                : Icons.notifications_off_outlined,
                            color: AppColors.textSecondary,
                          ),
                          title: Text(
                            l10n.notificationsLabel,
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            _notificationsEnabled
                                ? l10n.notificationsEnabledSubtitle
                                : l10n.notificationsDisabledSubtitle,
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          value: _notificationsEnabled,
                          onChanged: _toggleNotifications,
                        ),
                        if (_notificationsEnabled) ...[
                          const Divider(height: AppSpacing.md),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.reminderDaysLabel,
                                style: textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [0, 1, 2, 3, 7].map((int day) {
                                    return _buildReminderChip(day, l10n, textTheme);
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.sm),

                // ── Recent Payments ──
                _RecentPaymentsSection(subscriptionUid: subscription.uid),

                const SizedBox(height: AppSpacing.md),

                // ── Actions ──
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    icon: const Icon(Icons.settings_outlined),
                    label: Text(l10n.manageSubscriptionDetailLabel),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: isPaidThisMonth
                        ? null
                        : () {
                            Navigator.of(context).pop();
                            onMarkPaid?.call();
                          },
                    icon: Icon(
                      isPaidThisMonth
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                    ),
                    label: Text(
                      isPaidThisMonth ? l10n.alreadyPaidThisMonth : l10n.markAsPaid,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helper widgets
// ─────────────────────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _RecentPaymentsSection extends StatelessWidget {
  const _RecentPaymentsSection({required this.subscriptionUid});

  final String subscriptionUid;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    final isar = LocalDatabase.instance.isar;
    final String baseCurrency =
        UserSettingsService.baseCurrencyNotifier.value;

    return StreamBuilder<List<PaymentTransaction>>(
      stream: isar.paymentTransactions
          .filter()
          .isDeletedEqualTo(false)
          .subscriptionUidEqualTo(subscriptionUid)
          .sortByPaidAtDesc()
          .limit(5)
          .watch(fireImmediately: true),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<PaymentTransaction>> snapshot,
      ) {
        final List<PaymentTransaction> payments =
            snapshot.data ?? const <PaymentTransaction>[];

        if (payments.isEmpty) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    l10n.noPaymentsRecordedYet,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.recentPaymentsTitle,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      l10n.countRecorded(payments.length),
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                ...payments.map((PaymentTransaction tx) {
                  final bool showConverted =
                      tx.paidCurrency.toUpperCase() !=
                          baseCurrency.toUpperCase();

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          size: 16,
                          color: AppColors.success,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          tx.paidAt.toMonthDayYearCommaLabel(l10n.localeName),
                          style: textTheme.bodySmall,
                        ),
                        const Spacer(),
                        Text(
                          showConverted
                              ? '${tx.snapshotBaseAmount.toStringAsFixed(2)} ${tx.snapshotBaseCurrency}'
                              : '${tx.paidAmount.toStringAsFixed(2)} ${tx.paidCurrency}',
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
