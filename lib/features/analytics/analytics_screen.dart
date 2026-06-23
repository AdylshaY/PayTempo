import 'package:flutter/material.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Text(l10n.analyticsScreenPlaceholder),
      ),
    );
  }
}