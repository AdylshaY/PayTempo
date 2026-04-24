import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/features/subscriptions/add_subscription_screen.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_templates.dart';
import 'package:pay_tempo/features/subscriptions/models/subscription_template_selection_model.dart';
import 'package:pay_tempo/features/subscriptions/widgets/subscription_template_tile_widget.dart';

Future<bool?> showSubscriptionTemplateBottomSheet(BuildContext context) async {
  final TemplateSelection? selection =
      await showModalBottomSheet<TemplateSelection>(
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
  State<_SubscriptionTemplateBottomSheet> createState() =>
      _SubscriptionTemplateBottomSheetState();
}

class _SubscriptionTemplateBottomSheetState
    extends State<_SubscriptionTemplateBottomSheet> {
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
            Text('Preset Services', style: textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Pick a service. You can enter the price on the next form screen.',
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
                  final SubscriptionTemplate template =
                      subscriptionTemplates[index];

                  return SubscriptionTemplateTile(
                    template: template,
                    onTap: () {
                      Navigator.of(context).pop(
                        TemplateSelection.template(template: template),
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
                  Navigator.of(context).pop(const TemplateSelection.manual());
                },
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Add Manually'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}