class SubscriptionDraft {
  SubscriptionDraft({
    required this.name,
    required this.category,
    this.avatarType,
    this.avatarEmoji,
    this.avatarIconCodePoint,
    this.avatarIconFontFamily,
    this.avatarIconFontPackage,
    this.avatarColorValue,
    required this.price,
    required this.currency,
    required this.billingCycle,
    required this.firstPaymentDate,
    this.userId,
    this.note,
    this.totalInstallments,
    this.remainingInstallments,
  });

  final String name;
  final String category;
  final String? note;
  final String? avatarType;
  final String? avatarEmoji;
  final int? avatarIconCodePoint;
  final String? avatarIconFontFamily;
  final String? avatarIconFontPackage;
  final int? avatarColorValue;
  final double price;
  final String currency;
  final String billingCycle;
  final DateTime firstPaymentDate;
  final String? userId;
  final int? totalInstallments;
  final int? remainingInstallments;
}