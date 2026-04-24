import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/features/subscriptions/add_subscription_screen.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_templates.dart';

class _TemplateSelection {
  const _TemplateSelection.manual()
      : isManual = true,
        template = null;

  const _TemplateSelection.template({
    required this.template,
  }) : isManual = false;

  final bool isManual;
  final SubscriptionTemplate? template;
}

Future<bool?> showSubscriptionTemplateBottomSheet(BuildContext context) async {
  final _TemplateSelection? selection = await showModalBottomSheet<_TemplateSelection>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (BuildContext context) => const _SubscriptionTemplateBottomSheet(),
  );

  if (selection == null || !context.mounted) {
    return null;
  }

  if (selection.isManual) {
    return Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => const AddSubscriptionScreen(),
      ),
    );
  }

  return Navigator.of(context).push<bool>(
    MaterialPageRoute<bool>(
      builder: (_) => AddSubscriptionScreen(
        template: selection.template,
      ),
    ),
  );
}

class _SubscriptionTemplateBottomSheet extends StatefulWidget {
  const _SubscriptionTemplateBottomSheet();

  @override
  State<_SubscriptionTemplateBottomSheet> createState() => _SubscriptionTemplateBottomSheetState();
}

class _SubscriptionTemplateBottomSheetState extends State<_SubscriptionTemplateBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.sm,
          AppSpacing.xs,
          AppSpacing.sm,
          AppSpacing.sm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hazir Servisler', style: textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Servisi sec. Fiyati bir sonraki form ekraninda girersin.',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.xs,
                  mainAxisSpacing: AppSpacing.xs,
                  childAspectRatio: 1.15,
                ),
                itemCount: subscriptionTemplates.length,
                itemBuilder: (BuildContext context, int index) {
                  final SubscriptionTemplate template = subscriptionTemplates[index];

                  return _TemplateTile(
                    template: template,
                    onTap: () {
                      Navigator.of(context).pop(
                        _TemplateSelection.template(template: template),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop(const _TemplateSelection.manual());
                },
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Manuel Ekle'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TemplateTile extends StatelessWidget {
  const _TemplateTile({
    required this.template,
    required this.onTap,
  });

  final SubscriptionTemplate template;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.card),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
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
              const Spacer(),
              Text(template.title, style: textTheme.titleMedium),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  template.category,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
