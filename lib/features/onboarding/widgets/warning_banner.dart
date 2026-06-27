import 'package:flutter/material.dart';
import 'package:pay_tempo/app/widgets/info_banner_widget.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class WarningBanner extends StatelessWidget {
  const WarningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return InfoBannerWidget(
      icon: Icons.info_outline_rounded,
      accentColor: colorScheme.primary,
      message: l10n.warningBannerText,
    );
  }
}
