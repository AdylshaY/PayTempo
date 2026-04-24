class AvatarSelection {
  const AvatarSelection({
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