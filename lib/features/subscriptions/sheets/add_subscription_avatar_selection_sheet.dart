import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_avatar_emojis.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_avatar_options.dart';
import 'package:pay_tempo/features/subscriptions/models/add_subscription_avatar_selection_model.dart';

class AvatarSelectionSheet extends StatefulWidget {
  const AvatarSelectionSheet({
    required this.initialType,
    required this.initialIconIndex,
    required this.initialColorHex,
    required this.initialEmoji,
    super.key,
  });

  final String initialType;
  final int initialIconIndex;
  final String initialColorHex;
  final String initialEmoji;

  @override
  State<AvatarSelectionSheet> createState() => _AvatarSelectionSheetState();
}

class _AvatarSelectionSheetState extends State<AvatarSelectionSheet> {
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
            Text('Color Palette', style: textTheme.titleMedium),
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
              Text('Select Emoji', style: textTheme.titleMedium),
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
                    AvatarSelection(
                      type: _type,
                      iconIndex: _iconIndex,
                      colorHex: _colorHex,
                      emoji: _emoji,
                    ),
                  );
                },
                child: const Text('Save Selection'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}