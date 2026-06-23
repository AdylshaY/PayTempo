import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/features/subscriptions/data/services/category_service.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class AddCustomCategorySheet extends StatefulWidget {
  const AddCustomCategorySheet({super.key});

  @override
  State<AddCustomCategorySheet> createState() => _AddCustomCategorySheetState();
}

class _AddCustomCategorySheetState extends State<AddCustomCategorySheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  
  IconData _selectedIcon = Icons.category_outlined;
  bool _saving = false;

  final List<IconData> _categoryIcons = const <IconData>[
    Icons.category_outlined,
    Icons.folder_outlined,
    Icons.sell_outlined,
    Icons.payment_outlined,
    Icons.wallet_outlined,
    Icons.credit_card_outlined,
    Icons.favorite_outline,
    Icons.star_outline,
    Icons.home_outlined,
    Icons.directions_car_outlined,
    Icons.restaurant_outlined,
    Icons.fitness_center_outlined,
    Icons.shopping_cart_outlined,
    Icons.computer_outlined,
    Icons.phone_iphone_outlined,
    Icons.pets_outlined,
    Icons.flight_outlined,
    Icons.vpn_key_outlined,
    Icons.lock_outline,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    final FormState? state = _formKey.currentState;
    if (state == null || !state.validate()) {
      return;
    }

    final String name = _nameController.text.trim();
    setState(() {
      _saving = true;
    });

    try {
      final bool exists = await CategoryService.instance.categoryExists(name);
      if (exists) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.categoryNameExists)),
        );
        setState(() {
          _saving = false;
        });
        return;
      }

      await CategoryService.instance.createCustomCategory(name, _selectedIcon);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.categorySavedSuccess)),
      );
      Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.failedToSaveCategory)),
      );
      setState(() {
        _saving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.sm,
        0,
        AppSpacing.sm,
        MediaQuery.of(context).viewInsets.bottom + AppSpacing.sm,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.addCategoryLabel, style: textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            TextFormField(
              controller: _nameController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: l10n.categoryNameLabel,
                hintText: 'e.g. Health, Workspace',
              ),
              validator: (String? value) {
                final String text = value?.trim() ?? '';
                if (text.isEmpty) {
                  return l10n.categoryNameRequired;
                }
                if (text.length < 2) {
                  return l10n.categoryNameMinLength;
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.categoryIconLabel, style: textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.xs),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 180),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: AppSpacing.xs,
                  mainAxisSpacing: AppSpacing.xs,
                ),
                itemCount: _categoryIcons.length,
                itemBuilder: (BuildContext context, int index) {
                  final IconData icon = _categoryIcons[index];
                  final bool isSelected = icon == _selectedIcon;
                  return Material(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.12)
                        : AppColors.inactive.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadii.button),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppRadii.button),
                      onTap: () => setState(() => _selectedIcon = icon),
                      child: Icon(
                        icon,
                        color: isSelected ? AppColors.primary : AppColors.textSecondary,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _submit,
                child: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(l10n.addCategory),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
