import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';

class AppDropdownFieldWidget<T> extends StatelessWidget {
  const AppDropdownFieldWidget({
    required this.initialSelection,
    required this.entries,
    required this.onSelected,
    this.labelText,
    this.hintText,
    this.enabled = true,
    super.key,
  });

  final T? initialSelection;
  final List<DropdownMenuEntry<T>> entries;
  final ValueChanged<T?> onSelected;
  final String? labelText;
  final String? hintText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final InputDecorationThemeData baseInputTheme =
        theme.inputDecorationTheme;

    final TextStyle? dropdownTextStyle = textTheme.bodyMedium?.copyWith(
      color: AppColors.textPrimary,
    );

    return DropdownMenu<T>(
      initialSelection: initialSelection,
      enabled: enabled,
      onSelected: onSelected,
      label: labelText == null ? null : Text(labelText!),
      hintText: hintText,
      textStyle: dropdownTextStyle,
      expandedInsets: EdgeInsets.zero,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(theme.colorScheme.surface),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.card),
          ),
        ),
      ),
      inputDecorationTheme: baseInputTheme.copyWith(
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      dropdownMenuEntries: entries,
    );
  }
}