import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';
import 'package:pay_tempo/app/widgets/app_dropdown_field_widget.dart';
import 'package:pay_tempo/app/widgets/app_segmented_control.dart';
import 'package:pay_tempo/features/onboarding/data/onboarding_currencies.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';
import 'package:pay_tempo/features/subscriptions/data/models/subscription_draft.dart';
import 'package:pay_tempo/features/subscriptions/data/services/subscription_service.dart';
import 'package:pay_tempo/features/subscriptions/data/services/category_service.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_avatar_emojis.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_avatar_options.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_categories.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_templates.dart';
import 'package:pay_tempo/features/subscriptions/models/add_subscription_avatar_selection_model.dart';
import 'package:pay_tempo/features/subscriptions/sheets/add_subscription_avatar_selection_sheet.dart';
import 'package:pay_tempo/features/subscriptions/sheets/add_custom_category_sheet.dart';
import 'package:pay_tempo/app/utils/date_formatter.dart';

class AddSubscriptionScreen extends StatefulWidget {
  const AddSubscriptionScreen({
    this.initialPriceOverride,
    this.template,
    this.subscriptionToEdit,
    super.key,
  });

  final double? initialPriceOverride;
  final SubscriptionTemplate? template;
  final SubscriptionRecord? subscriptionToEdit;

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final ValueNotifier<String> _category = ValueNotifier<String>(
    subscriptionCategories.first.value,
  );
  final ValueNotifier<String> _avatarType = ValueNotifier<String>('icon');
  final ValueNotifier<int> _selectedIconIndex = ValueNotifier<int>(0);
  final ValueNotifier<String> _selectedColorHex = ValueNotifier<String>(
    '4F46E5',
  );
  String _selectedEmoji = subscriptionAvatarEmojis.first;
  final ValueNotifier<String> _currency = ValueNotifier<String>(
    onboardingCurrencies.first.code,
  );
  final ValueNotifier<String> _billingCycle = ValueNotifier<String>('monthly');
  final ValueNotifier<DateTime> _firstPaymentDate = ValueNotifier<DateTime>(
    DateTime.now(),
  );
  final ValueNotifier<bool> _saving = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isInstallment = ValueNotifier<bool>(false);
  final TextEditingController _totalInstallmentsController = TextEditingController();
  final TextEditingController _remainingInstallmentsController = TextEditingController();
  bool _l10nInitialized = false;

  final SubscriptionService _subscriptionService = SubscriptionService();

  bool get _isTemplateFlow => widget.template != null;

  String get _serviceName => _nameController.text.trim();

  IconData? get _templateAvatarIcon => widget.template?.icon;

  Color? get _templateAvatarColor => widget.template?.brandColor;

  String _categoryValueFromTemplate(String categoryLabel) {
    return subscriptionCategories
        .firstWhere(
          (SubscriptionCategoryOption item) =>
              item.label.toLowerCase() == categoryLabel.toLowerCase() ||
              item.value.toLowerCase() == categoryLabel.toLowerCase(),
          orElse: () => subscriptionCategories.first,
        )
        .value;
  }

  SubscriptionAvatarIconOption _selectedAvatarIcon() {
    return subscriptionAvatarIcons[_selectedIconIndex.value];
  }

  Color _selectedAvatarColor() {
    try {
      return Color(int.parse(_selectedColorHex.value, radix: 16) | 0xFF000000);
    } catch (_) {
      return AppColors.primary;
    }
  }

  Widget _avatarPreview() {
    final Color backgroundColor =
        _templateAvatarColor ?? _selectedAvatarColor();
    final Widget content;

    if (_isTemplateFlow) {
      content = Icon(
        _templateAvatarIcon ?? _selectedAvatarIcon().icon,
        color: Colors.white,
        size: 32,
      );
    } else if (_avatarType.value == 'emoji') {
      content = Text(_selectedEmoji, style: const TextStyle(fontSize: 30));
    } else {
      content = Icon(_selectedAvatarIcon().icon, color: Colors.white, size: 32);
    }

    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: backgroundColor.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: content,
    );
  }

  Future<void> _openAvatarSelector() async {
    if (_isTemplateFlow) {
      return;
    }

    final AvatarSelection? selection =
        await showModalBottomSheet<AvatarSelection>(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (BuildContext context) {
            return AvatarSelectionSheet(
              initialType: _avatarType.value,
              initialIconIndex: _selectedIconIndex.value,
              initialColorHex: _selectedColorHex.value,
              initialEmoji: _selectedEmoji,
            );
          },
        );

    if (selection == null || !mounted) {
      return;
    }

    setState(() {
      _avatarType.value = selection.type;
      _selectedIconIndex.value = selection.iconIndex;
      _selectedColorHex.value = selection.colorHex;
      _selectedEmoji = selection.emoji;
    });
  }

  List<SubscriptionCategoryOption> _categoryOptions = [];

  Future<void> _loadCategoryOptions() async {
    final list = await CategoryService.instance.getAllCategoryOptions();
    setState(() {
      _categoryOptions = list;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCategoryOptions();

    final SubscriptionRecord? editSub = widget.subscriptionToEdit;
    final SubscriptionTemplate? template = widget.template;

    if (editSub != null) {
      _nameController.text = editSub.name;
      _priceController.text = editSub.price.toStringAsFixed(2);
      _noteController.text = editSub.note ?? '';
      _category.value = editSub.category;
      _avatarType.value = editSub.avatarType ?? 'icon';
      _selectedEmoji = editSub.avatarEmoji ?? '';
      _currency.value = editSub.currency;
      _billingCycle.value = editSub.billingCycle;
      _firstPaymentDate.value = editSub.nextPaymentDate;

      if (editSub.avatarIconCodePoint != null) {
        final idx = subscriptionAvatarIcons.indexWhere(
          (option) => option.icon.codePoint == editSub.avatarIconCodePoint,
        );
        _selectedIconIndex.value = idx >= 0 ? idx : 0;
      }

      if (editSub.avatarColorValue != null) {
        _selectedColorHex.value = Color(editSub.avatarColorValue!)
            .toARGB32()
            .toRadixString(16)
            .substring(2)
            .toUpperCase();
      }

      if (editSub.totalInstallments != null) {
        _isInstallment.value = true;
        _totalInstallmentsController.text = editSub.totalInstallments.toString();
        _remainingInstallmentsController.text = editSub.remainingInstallments.toString();
      }
    } else if (template != null) {
      _nameController.text = template.title;
      _category.value = _categoryValueFromTemplate(template.category);
      _avatarType.value = 'icon';
      _selectedIconIndex.value = subscriptionAvatarIcons.indexWhere(
        (SubscriptionAvatarIconOption option) => option.icon == template.icon,
      );
      if (_selectedIconIndex.value < 0) {
        _selectedIconIndex.value = 0;
      }
      _selectedColorHex.value = template.brandColor
          .toARGB32()
          .toRadixString(16)
          .substring(2)
          .toUpperCase();

      if (template.id == 'installment') {
        _isInstallment.value = true;
      }
    }

    if (widget.initialPriceOverride != null && editSub == null) {
      _priceController.text = widget.initialPriceOverride!.toString();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_l10nInitialized) {
      final template = widget.template;
      if (template != null) {
        final l10n = AppLocalizations.of(context)!;
        _nameController.text = getTemplateTitle(template.id, template.title, l10n);
      }
      _l10nInitialized = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _noteController.dispose();
    _category.dispose();
    _avatarType.dispose();
    _selectedIconIndex.dispose();
    _selectedColorHex.dispose();
    _currency.dispose();
    _billingCycle.dispose();
    _firstPaymentDate.dispose();
    _saving.dispose();
    _isInstallment.dispose();
    _totalInstallmentsController.dispose();
    _remainingInstallmentsController.dispose();
    super.dispose();
  }

  String? _avatarTypeForSubmission() {
    if (_isTemplateFlow) {
      return 'icon';
    }

    if (_avatarType.value == 'emoji') {
      return _selectedEmoji.isEmpty ? null : 'emoji';
    }
    return 'icon';
  }

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = _firstPaymentDate.value;

    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 10),
    );

    if (selected == null) {
      return;
    }

    _firstPaymentDate.value = selected;
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    final FormState? state = _formKey.currentState;
    if (state == null || !state.validate()) {
      return;
    }

    final double? parsedPrice = double.tryParse(
      _priceController.text.trim().replaceAll(',', '.'),
    );

    if (parsedPrice == null || parsedPrice <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.enterValidAmount)),
      );
      return;
    }

    _saving.value = true;
    final bool isEdit = widget.subscriptionToEdit != null;

    try {
      final draft = SubscriptionDraft(
        name: _serviceName,
        category: _category.value,
        avatarType: _avatarTypeForSubmission(),
        avatarEmoji: !_isTemplateFlow && _avatarType.value == 'emoji'
            ? _selectedEmoji
            : null,
        avatarIconCodePoint: _isTemplateFlow
            ? _templateAvatarIcon?.codePoint
            : _avatarType.value == 'icon'
            ? _selectedAvatarIcon().icon.codePoint
            : null,
        avatarIconFontFamily: _isTemplateFlow
            ? _templateAvatarIcon?.fontFamily
            : _avatarType.value == 'icon'
            ? _selectedAvatarIcon().icon.fontFamily
            : null,
        avatarIconFontPackage: _isTemplateFlow
            ? _templateAvatarIcon?.fontPackage
            : _avatarType.value == 'icon'
            ? _selectedAvatarIcon().icon.fontPackage
            : null,
        avatarColorValue: (_templateAvatarColor ?? _selectedAvatarColor())
            .toARGB32(),
        price: parsedPrice,
        currency: _currency.value,
        billingCycle: _billingCycle.value,
        firstPaymentDate: _firstPaymentDate.value,
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
        totalInstallments: _isInstallment.value
            ? int.tryParse(_totalInstallmentsController.text.trim())
            : null,
        remainingInstallments: _isInstallment.value
            ? int.tryParse(_remainingInstallmentsController.text.trim())
            : null,
      );

      if (isEdit) {
        await _subscriptionService.updateSubscription(
          widget.subscriptionToEdit!,
          draft,
        );
      } else {
        await _subscriptionService.createSubscription(draft);
      }

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.failedToSaveSubscription),
        ),
      );
      _saving.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.subscriptionToEdit != null
              ? l10n.editSubscription
              : (_isTemplateFlow ? l10n.presetServiceSettings : l10n.newSubscription),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.sm),
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(AppRadii.card),
                onTap: _openAvatarSelector,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Row(
                      children: [
                        _avatarPreview(),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l10n.avatarLabel, style: textTheme.titleMedium),
                              const SizedBox(height: 4),
                              Text(
                                _isTemplateFlow
                                    ? l10n.presetAvatarDesc
                                    : l10n.tapToSelectAvatarDesc,
                                style: textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!_isTemplateFlow) const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: l10n.subscriptionNameLabel,
                  hintText: l10n.subscriptionNameHint,
                ),
                validator: (String? value) {
                  final String text = value?.trim() ?? '';
                  if (text.isEmpty) {
                    return l10n.subscriptionNameRequired;
                  }
                  if (text.length < 2) {
                    return l10n.subscriptionNameMinLength;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _noteController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: l10n.noteLabel,
                  hintText: l10n.noteHint,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              ValueListenableBuilder<String>(
                valueListenable: _category,
                builder: (BuildContext context, String selectedCategory, _) {
                  final List<DropdownMenuEntry<String>> dropdownEntries = _categoryOptions
                      .map(
                        (item) => DropdownMenuEntry<String>(
                          value: item.value,
                          label: getCategoryLabel(item.value, l10n),
                          leadingIcon: Icon(item.icon, size: 18),
                        ),
                      )
                      .toList();

                  // Append "+ Add Custom Category" option at the bottom
                  dropdownEntries.add(
                    DropdownMenuEntry<String>(
                      value: '_add_custom_',
                      label: l10n.addCategory,
                      leadingIcon: const Icon(Icons.add_rounded, size: 18),
                    ),
                  );

                  return AppDropdownFieldWidget<String>(
                    key: ValueKey<String>('${selectedCategory}_${_categoryOptions.length}'),
                    initialSelection: selectedCategory,
                    labelText: l10n.categoryLabel,
                    entries: dropdownEntries,
                    onSelected: (String? value) async {
                      if (value == null) {
                        return;
                      }

                      if (value == '_add_custom_') {
                        if (!context.mounted) return;

                        // Open custom category creator
                        final bool? added = await showModalBottomSheet<bool>(
                          context: context,
                          isScrollControlled: true,
                          showDragHandle: true,
                          builder: (BuildContext context) {
                            return const AddCustomCategorySheet();
                          },
                        );

                        if (added == true && context.mounted) {
                          await _loadCategoryOptions();
                          final newCat = CategoryService.instance.cachedCustomCategories.firstOrNull;
                          if (newCat != null) {
                            _category.value = newCat.name;
                          }
                        } else {
                          // User cancelled sheet, revert selection to previous value
                          _category.value = _category.value;
                        }
                      } else {
                        _category.value = value;
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _priceController,
                textInputAction: TextInputAction.done,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: l10n.priceLabel,
                  hintText: l10n.priceHint,
                ),
                validator: (String? value) {
                  final String text = value?.trim() ?? '';
                  if (text.isEmpty) {
                    return l10n.priceRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              ValueListenableBuilder<String>(
                valueListenable: _currency,
                builder: (BuildContext context, String selectedCurrency, _) {
                  return AppDropdownFieldWidget<String>(
                    initialSelection: selectedCurrency,
                    labelText: l10n.currencyLabel,
                    entries: onboardingCurrencies
                        .map(
                          (item) => DropdownMenuEntry<String>(
                            value: item.code,
                            label: '${item.code} - ${getCurrencyLabel(item.code, l10n)}',
                          ),
                        )
                        .toList(growable: false),
                    onSelected: (String? value) {
                      if (value == null) {
                        return;
                      }
                      _currency.value = value;
                    },
                  );
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              ValueListenableBuilder<String>(
                valueListenable: _billingCycle,
                builder: (BuildContext context, String cycle, _) {
                  return AppSegmentedControl<String>(
                    width: double.infinity,
                    tabs: [
                      AppSegmentedTab<String>(
                        value: 'monthly',
                        label: l10n.monthlyLabel,
                      ),
                      AppSegmentedTab<String>(
                        value: 'yearly',
                        label: l10n.yearlyLabel,
                      ),
                    ],
                    selectedValue: cycle,
                    onValueChanged: (String val) {
                      _billingCycle.value = val;
                    },
                  );
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              ValueListenableBuilder<DateTime>(
                valueListenable: _firstPaymentDate,
                builder: (BuildContext context, DateTime date, _) {
                  final String formatted = date.toFullDateLabel(l10n.localeName);
                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      title: Text(l10n.firstPaymentDateLabel),
                      subtitle: Text(formatted),
                      trailing: IconButton(
                        onPressed: _pickDate,
                        icon: const Icon(Icons.calendar_today_outlined),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              ValueListenableBuilder<bool>(
                valueListenable: _isInstallment,
                builder: (BuildContext context, bool isInstall, _) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      child: Column(
                        children: [
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              l10n.isInstallmentLabel,
                              style: textTheme.titleMedium,
                            ),
                            value: isInstall,
                            onChanged: (bool value) {
                              _isInstallment.value = value;
                            },
                          ),
                          if (isInstall) ...[
                            const SizedBox(height: AppSpacing.sm),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _totalInstallmentsController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: l10n.totalInstallmentsLabel,
                                    ),
                                    validator: (String? value) {
                                      if (!isInstall) return null;
                                      final String text = value?.trim() ?? '';
                                      if (text.isEmpty) {
                                        return l10n.fieldRequired;
                                      }
                                      final int? total = int.tryParse(text);
                                      if (total == null || total <= 0) {
                                        return l10n.invalidNumber;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: TextFormField(
                                    controller: _remainingInstallmentsController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      labelText: l10n.remainingInstallmentsLabel,
                                    ),
                                    validator: (String? value) {
                                      if (!isInstall) return null;
                                      final String text = value?.trim() ?? '';
                                      if (text.isEmpty) {
                                        return l10n.fieldRequired;
                                      }
                                      final int? remaining = int.tryParse(text);
                                      if (remaining == null || remaining < 0) {
                                        return l10n.invalidNumber;
                                      }
                                      final int? total = int.tryParse(_totalInstallmentsController.text.trim());
                                      if (total != null && remaining > total) {
                                        return l10n.validationInstallmentRange;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),
              ValueListenableBuilder<bool>(
                valueListenable: _saving,
                builder: (BuildContext context, bool saving, _) {
                  return ElevatedButton(
                    onPressed: saving ? null : _submit,
                    child: saving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(l10n.saveSubscriptionLabel),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
