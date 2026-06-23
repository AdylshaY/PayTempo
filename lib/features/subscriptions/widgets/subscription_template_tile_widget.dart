import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_templates.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_categories.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class SubscriptionTemplateTile extends StatelessWidget {
  const SubscriptionTemplateTile({
    required this.template,
    required this.onTap,
    super.key,
  });

  final SubscriptionTemplate template;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.card),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: template.brandColor,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: template.brandColor.withValues(alpha: 0.18),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(
                    template.icon,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                template.title,
                style: textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  getCategoryLabel(template.category, l10n),
                  style: textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}