import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';

class ProUpgradeScreen extends StatelessWidget {
  const ProUpgradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Upgrade to Pro')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(AppRadii.button),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.workspace_premium_rounded,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text('Pro Benefits', style: textTheme.titleMedium),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _BenefitRow(
                        icon: Icons.cloud_sync_outlined,
                        label: 'Cloud backup for your local data',
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      _BenefitRow(
                        icon: Icons.devices_outlined,
                        label: 'Sync across your devices',
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      _BenefitRow(
                        icon: Icons.shield_outlined,
                        label: 'Safer recovery when switching phones',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Your current app keeps working fully offline. Pro only adds optional sync and backup.',
                style: textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pro purchase flow will be available soon.'),
                      ),
                    );
                  },
                  child: const Text('Continue to Pro'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: AppSpacing.xs),
        Expanded(child: Text(label, style: textTheme.bodyMedium)),
      ],
    );
  }
}
