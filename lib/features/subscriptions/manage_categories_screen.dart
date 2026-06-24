import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/custom_category.dart';
import 'package:pay_tempo/features/subscriptions/data/services/category_service.dart';
import 'package:pay_tempo/features/subscriptions/sheets/add_custom_category_sheet.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class ManageCategoriesScreen extends StatefulWidget {
  const ManageCategoriesScreen({super.key});

  @override
  State<ManageCategoriesScreen> createState() => _ManageCategoriesScreenState();
}

class _ManageCategoriesScreenState extends State<ManageCategoriesScreen> {
  final CategoryService _categoryService = CategoryService.instance;
  List<CustomCategory> _categories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() => _loading = true);
    final list = await _categoryService.getCustomCategories();
    setState(() {
      _categories = list;
      _loading = false;
    });
  }

  Future<void> _openAddCategorySheet() async {
    final bool? added = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return const AddCustomCategorySheet();
      },
    );

    if (added == true) {
      _loadCategories();
    }
  }

  Future<void> _confirmDeleteCategory(CustomCategory category) async {
    final l10n = AppLocalizations.of(context)!;
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.deleteCategory),
          content: Text(l10n.deleteCategoryConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.cancelButtonLabel),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.deleteCategory),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      try {
        await _categoryService.deleteCustomCategory(category.id);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.categoryDeletedSuccess)),
        );
        _loadCategories();
      } catch (_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('Failed to delete category.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.manageCategories),
        actions: [
          IconButton(
            onPressed: _openAddCategorySheet,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _categories.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.category_outlined,
                            size: 64,
                            color: AppColors.inactive.withValues(alpha: 0.8),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            l10n.noCustomCategoriesYet,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    itemCount: _categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      final category = _categories[index];
                      final IconData icon = IconData(
                        category.iconCodePoint,
                        fontFamily: category.iconFontFamily,
                        fontPackage: category.iconFontPackage,
                      );

                      return Card(
                        margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: ListTile(
                          leading: Icon(icon, color: AppColors.primary),
                          title: Text(category.name),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: AppColors.error),
                            onPressed: () => _confirmDeleteCategory(category),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
