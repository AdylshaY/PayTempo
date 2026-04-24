import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/services/subscription_service.dart';
import 'package:pay_tempo/features/onboarding/data/onboarding_currencies.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_avatar_emojis.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_avatar_options.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_categories.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_templates.dart';

class AddSubscriptionScreen extends StatefulWidget {
  const AddSubscriptionScreen({
    this.initialPriceOverride,
    this.template,
    super.key,
  });

  final double? initialPriceOverride;
  final SubscriptionTemplate? template;

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
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

  final SubscriptionService _subscriptionService = SubscriptionService();

  bool get _isTemplateFlow => widget.template != null;

  String get _serviceName =>
      widget.template?.title ?? _nameController.text.trim();

  IconData? get _templateAvatarIcon => widget.template?.icon;

  Color? get _templateAvatarColor => widget.template?.brandColor;

  String _categoryValueFromTemplate(String categoryLabel) {
    return subscriptionCategories
        .firstWhere(
          (SubscriptionCategoryOption item) =>
              item.label.toLowerCase() == categoryLabel.toLowerCase(),
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
      return Color(0xFF4F46E5);
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

    final _AvatarSelection? selection =
        await showModalBottomSheet<_AvatarSelection>(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (BuildContext context) {
            return _AvatarSelectorSheet(
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

  @override
  void initState() {
    super.initState();
    final SubscriptionTemplate? template = widget.template;
    if (template == null) {
      return;
    }

    _nameController.text = template.title;
    final double price = widget.initialPriceOverride ?? template.suggestedPrice;
    _priceController.text = price.toStringAsFixed(2);
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
    _currency.value = template.defaultCurrency;
    _billingCycle.value = template.defaultBillingCycle;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _category.dispose();
    _avatarType.dispose();
    _selectedIconIndex.dispose();
    _selectedColorHex.dispose();
    _currency.dispose();
    _billingCycle.dispose();
    _firstPaymentDate.dispose();
    _saving.dispose();
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
    final FormState? state = _formKey.currentState;
    if (state == null || !state.validate()) {
      return;
    }

    final double? parsedPrice = double.tryParse(
      _priceController.text.trim().replaceAll(',', '.'),
    );

    if (parsedPrice == null || parsedPrice <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lutfen gecerli bir tutar girin.')),
      );
      return;
    }

    _saving.value = true;

    try {
      await _subscriptionService.createSubscription(
        SubscriptionDraft(
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
        ),
      );

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Abonelik kaydedilemedi. Tekrar deneyin.'),
        ),
      );
      _saving.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isTemplateFlow ? 'Hazir Servis Ayarlari' : 'Yeni Abonelik',
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.sm),
            children: [
              Text(
                _isTemplateFlow ? 'Servis Ayarlari' : 'Abonelik Bilgileri',
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _isTemplateFlow
                    ? 'This is a preset configuration based on the selected service. You can adjust the price, currency, billing cycle, and first payment date as needed.'
                    : 'Enter the details of your subscription. You can customize the avatar, category, price, currency, billing cycle, and first payment date.',
                style: textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.md),
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
                              Text('Avatar', style: textTheme.titleMedium),
                              const SizedBox(height: 4),
                              Text(
                                _isTemplateFlow
                                    ? 'This is a preset avatar based on the selected service.'
                                    : 'Tap to select an icon, emoji, or color.',
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
              if (!_isTemplateFlow) ...[
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Subscription Name',
                    hintText: 'Example: Netflix',
                  ),
                  validator: (String? value) {
                    final String text = value?.trim() ?? '';
                    if (text.isEmpty) {
                      return 'Subscription name is required.';
                    }
                    if (text.length < 2) {
                      return 'Please enter at least 2 characters.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              ValueListenableBuilder<String>(
                valueListenable: _category,
                builder: (BuildContext context, String selectedCategory, _) {
                  return DropdownButtonFormField<String>(
                    initialValue: selectedCategory,
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: subscriptionCategories
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item.value,
                            child: Row(
                              children: [
                                Icon(item.icon, size: 18),
                                const SizedBox(width: 8),
                                Text(item.label),
                              ],
                            ),
                          ),
                        )
                        .toList(growable: false),
                    onChanged: (String? value) {
                      if (value == null) {
                        return;
                      }
                      _category.value = value;
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
                decoration: const InputDecoration(
                  labelText: 'Price',
                  hintText: 'Example: 9.99',
                ),
                validator: (String? value) {
                  final String text = value?.trim() ?? '';
                  if (text.isEmpty) {
                    return 'Price is required.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              ValueListenableBuilder<String>(
                valueListenable: _currency,
                builder: (BuildContext context, String selectedCurrency, _) {
                  return DropdownButtonFormField<String>(
                    initialValue: selectedCurrency,
                    decoration: const InputDecoration(labelText: 'Currency'),
                    items: onboardingCurrencies
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item.code,
                            child: Text('${item.code} - ${item.label}'),
                          ),
                        )
                        .toList(growable: false),
                    onChanged: (String? value) {
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
                  return SegmentedButton<String>(
                    segments: const <ButtonSegment<String>>[
                      ButtonSegment<String>(
                        value: 'monthly',
                        label: Text('Monthly'),
                      ),
                      ButtonSegment<String>(
                        value: 'yearly',
                        label: Text('Yearly'),
                      ),
                    ],
                    selected: <String>{cycle},
                    onSelectionChanged: (Set<String> selection) {
                      if (selection.isEmpty) {
                        return;
                      }
                      _billingCycle.value = selection.first;
                    },
                  );
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              ValueListenableBuilder<DateTime>(
                valueListenable: _firstPaymentDate,
                builder: (BuildContext context, DateTime date, _) {
                  final String formatted =
                      '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      title: const Text('First Payment Date'),
                      subtitle: Text(formatted),
                      trailing: IconButton(
                        onPressed: _pickDate,
                        icon: const Icon(Icons.calendar_today_outlined),
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
                        : const Text('Save Subscription'),
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

class _AvatarSelection {
  const _AvatarSelection({
    required this.type,
    required this.iconIndex,
    required this.colorHex,
    required this.emoji,
  });

  final String type;
  final int iconIndex;
  final String colorHex;
  final String emoji;
}

class _AvatarSelectorSheet extends StatefulWidget {
  const _AvatarSelectorSheet({
    required this.initialType,
    required this.initialIconIndex,
    required this.initialColorHex,
    required this.initialEmoji,
  });

  final String initialType;
  final int initialIconIndex;
  final String initialColorHex;
  final String initialEmoji;

  @override
  State<_AvatarSelectorSheet> createState() => _AvatarSelectorSheetState();
}

class _AvatarSelectorSheetState extends State<_AvatarSelectorSheet> {
  late String _type;
  late int _iconIndex;
  late String _colorHex;
  late String _emoji;

  @override
  void initState() {
    super.initState();
    _type = widget.initialType;
    _iconIndex = widget.initialIconIndex;
    _colorHex = widget.initialColorHex;
    _emoji = widget.initialEmoji;
  }

  Color get _selectedColor {
    try {
      return Color(int.parse(_colorHex, radix: 16) | 0xFF000000);
    } catch (_) {
      return Color(0xFF4F46E5);
    }
  }

  String _colorToHex(Color color) {
    return color.toARGB32().toRadixString(16).substring(2).toUpperCase();
  }

  Widget _preview() {
    return Container(
      width: 84,
      height: 84,
      decoration: BoxDecoration(
        color: _selectedColor,
        borderRadius: BorderRadius.circular(26),
      ),
      alignment: Alignment.center,
      child: _type == 'emoji'
          ? Text(_emoji, style: const TextStyle(fontSize: 34))
          : Icon(
              subscriptionAvatarIcons[_iconIndex].icon,
              color: Colors.white,
              size: 36,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.sm,
          0,
          AppSpacing.sm,
          AppSpacing.sm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: _preview()),
            const SizedBox(height: AppSpacing.sm),
            Center(
              child: SegmentedButton<String>(
                segments: const <ButtonSegment<String>>[
                  ButtonSegment<String>(
                    value: 'icon',
                    icon: Icon(Icons.apps_rounded),
                    label: Text('Icon'),
                  ),
                  ButtonSegment<String>(
                    value: 'emoji',
                    icon: Icon(Icons.emoji_emotions_outlined),
                    label: Text('Emoji'),
                  ),
                ],
                selected: <String>{_type},
                onSelectionChanged: (Set<String> selection) {
                  if (selection.isEmpty) {
                    return;
                  }
                  setState(() {
                    _type = selection.first;
                  });
                },
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text('Renk Paleti', style: textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: subscriptionAvatarPalette
                  .map((Color color) {
                    final String colorHex = _colorToHex(color);
                    final bool isSelected = colorHex == _colorHex;

                    return InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () {
                        setState(() {
                          _colorHex = colorHex;
                        });
                      },
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.textPrimary
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    );
                  })
                  .toList(growable: false),
            ),
            const SizedBox(height: AppSpacing.sm),
            if (_type == 'icon') ...[
              Text('Icon Selection', style: textTheme.titleMedium),
              const SizedBox(height: AppSpacing.xs),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: AppSpacing.xs,
                  mainAxisSpacing: AppSpacing.xs,
                ),
                itemCount: subscriptionAvatarIcons.length,
                itemBuilder: (BuildContext context, int index) {
                  final bool isSelected = index == _iconIndex;
                  return Material(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.12)
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadii.button),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppRadii.button),
                      onTap: () => setState(() => _iconIndex = index),
                      child: Icon(
                        subscriptionAvatarIcons[index].icon,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                    ),
                  );
                },
              ),
            ] else ...[
              Text('Emoji sec', style: textTheme.titleMedium),
              const SizedBox(height: AppSpacing.xs),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: AppSpacing.xs,
                  mainAxisSpacing: AppSpacing.xs,
                ),
                itemCount: subscriptionAvatarEmojis.length,
                itemBuilder: (BuildContext context, int index) {
                  final bool isSelected =
                      subscriptionAvatarEmojis[index] == _emoji;
                  return Material(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.12)
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadii.button),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppRadii.button),
                      onTap: () => setState(
                        () => _emoji = subscriptionAvatarEmojis[index],
                      ),
                      child: Center(
                        child: Text(
                          subscriptionAvatarEmojis[index],
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(
                    _AvatarSelection(
                      type: _type,
                      iconIndex: _iconIndex,
                      colorHex: _colorHex,
                      emoji: _emoji,
                    ),
                  );
                },
                child: const Text('Secimi Kaydet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
