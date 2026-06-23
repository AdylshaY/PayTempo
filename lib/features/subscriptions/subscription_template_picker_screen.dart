import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/features/subscriptions/add_subscription_screen.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_categories.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_templates.dart';
import 'package:pay_tempo/features/subscriptions/widgets/subscription_template_tile_widget.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

class SubscriptionTemplatePickerScreen extends StatefulWidget {
  const SubscriptionTemplatePickerScreen({super.key});

  @override
  State<SubscriptionTemplatePickerScreen> createState() =>
      _SubscriptionTemplatePickerScreenState();
}

class _SubscriptionTemplatePickerScreenState
    extends State<SubscriptionTemplatePickerScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  String _searchQuery = '';
  String _selectedCategory = 'all';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.trim().toLowerCase();
    });
  }

  List<SubscriptionTemplate> get _filteredTemplates {
    return subscriptionTemplates.where((template) {
      final bool matchesSearch =
          template.title.toLowerCase().contains(_searchQuery);
      
      final bool matchesCategory = _selectedCategory == 'all' ||
          template.category.toLowerCase() == _selectedCategory.toLowerCase();

      return matchesSearch && matchesCategory;
    }).toList();
  }

  Future<void> _handleTemplateSelected(SubscriptionTemplate template) async {
    final bool? created = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => AddSubscriptionScreen(template: template),
      ),
    );

    if (created == true && mounted) {
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _handleManualAdd() async {
    final bool? created = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => const AddSubscriptionScreen(),
      ),
    );

    if (created == true && mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final categories = <String>['all'];
    categories.addAll(subscriptionCategories.map((opt) => opt.value));

    final filteredList = _filteredTemplates;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.presetServicesTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Input
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: l10n.searchTemplates,
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                ),
              ),
            ),
            
            // Category Filter Chips
            SizedBox(
              height: 48,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  final String cat = categories[index];
                  final bool isSelected = _selectedCategory == cat;
                  final String label = cat == 'all'
                      ? l10n.allLabel
                      : getCategoryLabel(cat, l10n);

                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ChoiceChip(
                      label: Text(label),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        if (selected) {
                          setState(() {
                            _selectedCategory = cat;
                          });
                        }
                      },
                      labelStyle: textTheme.bodySmall?.copyWith(
                        color: isSelected
                            ? Colors.white
                            : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                      selectedColor: AppColors.primary,
                      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadii.button),
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.primary
                              : (isDark ? AppColors.inactiveDark : AppColors.inactive),
                          width: 1,
                        ),
                      ),
                      showCheckmark: false,
                    ),
                  );
                },
              ),
            ),
            
            // Grid of Templates
            Expanded(
              child: filteredList.isEmpty
                  ? Center(
                      child: Text(
                        l10n.noPaymentsMatchFilter, // fallback search empty state
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppSpacing.xs,
                        mainAxisSpacing: AppSpacing.xs,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: filteredList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final SubscriptionTemplate template = filteredList[index];
                        return SubscriptionTemplateTile(
                          template: template,
                          onTap: () => _handleTemplateSelected(template),
                        );
                      },
                    ),
            ),
            
            // Manual Add Button
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _handleManualAdd,
                  icon: const Icon(Icons.edit_outlined),
                  label: Text(l10n.addManuallyLabel),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
