import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/currency_formatter.dart';
import 'package:pay_tempo/app/utils/date_formatter.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/data/local/services/exchange_rate_service.dart';
import 'package:pay_tempo/features/subscriptions/data/services/subscription_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class MarkSubscriptionPaidSheet extends StatefulWidget {
  const MarkSubscriptionPaidSheet({
    required this.subscription,
    required this.baseCurrency,
    super.key,
  });

  final SubscriptionRecord subscription;
  final String baseCurrency;

  @override
  State<MarkSubscriptionPaidSheet> createState() =>
      _MarkSubscriptionPaidSheetState();
}

class _MarkSubscriptionPaidSheetState extends State<MarkSubscriptionPaidSheet> {
  late DateTime _selectedDate;
  bool _saving = false;
  final SubscriptionService _subscriptionService = SubscriptionService();

  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
  }



  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 10),
    );

    if (selected == null || !mounted) {
      return;
    }

    setState(() {
      _selectedDate = DateTime(selected.year, selected.month, selected.day);
    });
  }

  Future<void> _save() async {
    if (_saving) {
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      await _subscriptionService.markSubscriptionAsPaid(
        subscription: widget.subscription,
        paidAt: _selectedDate,
        baseCurrency: widget.baseCurrency,
      );

      if (!mounted) {
        return;
      }

      HapticFeedback.mediumImpact();
      Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _saving = false;
      });

      final l10n = AppLocalizations.of(context)!;
      final String message = _selectedDate.month == DateTime.now().month &&
              _selectedDate.year == DateTime.now().year
          ? l10n.markPaidSuccess
          : l10n.markPaidFailed;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.sm,
          AppSpacing.sm,
          AppSpacing.sm,
          AppSpacing.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.markAsPaid, style: textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              widget.subscription.name,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Card(
              child: ListTile(
                title: Text(l10n.paymentDateLabel),
                subtitle: Text(_selectedDate.toMonthDayYearCommaLabel(l10n.localeName)),
                trailing: const Icon(Icons.calendar_today_outlined),
                onTap: _saving ? null : _pickDate,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.amountLabel,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          CurrencyFormatter.format(widget.subscription.price, widget.subscription.currency),
                          style: textTheme.titleMedium,
                        ),
                        if (widget.subscription.currency.toUpperCase() !=
                            widget.baseCurrency.toUpperCase())
                          Builder(builder: (BuildContext context) {
                            final double converted =
                                ExchangeRateService.instance.convert(
                              widget.subscription.price,
                              widget.subscription.currency,
                              widget.baseCurrency,
                            );
                            return Text(
                              '≈ ${CurrencyFormatter.format(converted, widget.baseCurrency)}',
                              style: textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            );
                          }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _saving ? null : () => Navigator.of(context).pop(false),
                    child: Text(l10n.cancelButtonLabel),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saving ? null : _save,
                    child: _saving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.savePaymentLabel),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}