import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppSegmentedTab<T> {
  const AppSegmentedTab({
    required this.value,
    required this.label,
    this.icon,
  });

  final T value;
  final String label;
  final IconData? icon;
}

class AppSegmentedControl<T> extends StatelessWidget {
  const AppSegmentedControl({
    super.key,
    required this.tabs,
    required this.selectedValue,
    required this.onValueChanged,
    this.width,
    this.height = 38,
  });

  final List<AppSegmentedTab<T>> tabs;
  final T selectedValue;
  final ValueChanged<T> onValueChanged;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: tabs.map((AppSegmentedTab<T> tab) {
          final bool isSelected = tab.value == selectedValue;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                if (!isSelected) {
                  HapticFeedback.lightImpact();
                  onValueChanged(tab.value);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: isSelected ? colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (tab.icon != null) ...[
                      Icon(
                        tab.icon,
                        size: 16,
                        color: isSelected
                            ? Colors.white
                            : colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      tab.label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
