import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/app/utils/date_formatter.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class PaymentsFilterSheet extends StatefulWidget {
  const PaymentsFilterSheet({
    super.key,
    required this.initialFromDate,
    required this.initialToDate,
  });

  final DateTime initialFromDate;
  final DateTime initialToDate;

  @override
  State<PaymentsFilterSheet> createState() => _PaymentsFilterSheetState();
}

class _PaymentsFilterSheetState extends State<PaymentsFilterSheet> {
  late DateTime? _fromDate;
  late DateTime? _toDate;

  @override
  void initState() {
    super.initState();
    _fromDate = widget.initialFromDate;
    _toDate = widget.initialToDate;
  }



  Future<void> _pickFromDate() async {
    final DateTime now = DateTime.now();
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _fromDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 10),
    );

    if (selected == null || !mounted) {
      return;
    }

    setState(() {
      _fromDate = DateTime(selected.year, selected.month, selected.day);
      if (_toDate != null && _fromDate!.isAfter(_toDate!)) {
        _toDate = _fromDate;
      }
    });
  }

  Future<void> _pickToDate() async {
    final DateTime now = DateTime.now();
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _toDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 10),
    );

    if (selected == null || !mounted) {
      return;
    }

    setState(() {
      _toDate = DateTime(selected.year, selected.month, selected.day);
      if (_fromDate != null && _fromDate!.isAfter(_toDate!)) {
        _fromDate = _toDate;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Text(
              l10n.filterPaymentsTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.fromDateLabel),
              subtitle: Text(
                _fromDate == null ? l10n.anyTime : _fromDate!.toFullDateLabel(l10n.localeName),
              ),
              trailing: const Icon(Icons.calendar_month_outlined),
              onTap: _pickFromDate,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.toDateLabel),
              subtitle: Text(
                _toDate == null ? l10n.anyTime : _toDate!.toFullDateLabel(l10n.localeName),
              ),
              trailing: const Icon(Icons.calendar_month_outlined),
              onTap: _pickToDate,
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(
                      context,
                    ).pop((fromDate: null, toDate: null)),
                    child: Text(l10n.clearLabel),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(
                      context,
                    ).pop((fromDate: _fromDate, toDate: _toDate)),
                    child: Text(l10n.applyLabel),
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
