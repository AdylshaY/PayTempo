import 'package:pay_tempo/features/subscriptions/data/subscription_templates.dart';

class TemplateSelection {
  const TemplateSelection.manual()
      : isManual = true,
        template = null;

  const TemplateSelection.template({
    required this.template,
  }) : isManual = false;

  final bool isManual;
  final SubscriptionTemplate? template;
}