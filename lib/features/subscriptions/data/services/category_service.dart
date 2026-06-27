import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/models/custom_category.dart';
import 'package:pay_tempo/features/subscriptions/data/subscription_categories.dart';

class CategoryService {
  CategoryService({Isar? isar}) : _isar = isar ?? LocalDatabase.instance.isar;

  final Isar _isar;

  static final CategoryService instance = CategoryService();

  // In-memory cache for active custom categories.
  List<CustomCategory> _customCategoriesCache = [];

  Future<void> initialize() async {
    await reloadCache();
  }

  Future<void> reloadCache() async {
    _customCategoriesCache = await _isar.customCategorys
        .filter()
        .isDeletedEqualTo(false)
        .sortByUpdatedAtDesc()
        .findAll();
  }

  List<CustomCategory> get cachedCustomCategories => _customCategoriesCache;

  Future<List<CustomCategory>> getCustomCategories() async {
    await reloadCache();
    return _customCategoriesCache;
  }

  /// Returns a combined list of predefined and active custom categories.
  Future<List<SubscriptionCategoryOption>> getAllCategoryOptions() async {
    final List<SubscriptionCategoryOption> list = [];
    list.addAll(subscriptionCategories);

    final List<CustomCategory> customList = await getCustomCategories();
    for (final CustomCategory cc in customList) {
      list.add(
        SubscriptionCategoryOption(
          value: cc.name,
          label: cc.name,
          icon: IconData(
            cc.iconCodePoint,
            fontFamily: cc.iconFontFamily,
            fontPackage: cc.iconFontPackage,
          ),
          color: const Color(0xFF94A3B8),
        ),
      );
    }
    return list;
  }

  /// Returns the icon for a category, checking predefined list first and then custom cache.
  IconData getIconForCategory(String categoryName) {
    final SubscriptionCategoryOption predefined = subscriptionCategories.firstWhere(
      (SubscriptionCategoryOption opt) => opt.value.toLowerCase() == categoryName.toLowerCase(),
      orElse: () => const SubscriptionCategoryOption(
        value: '',
        label: '',
        icon: Icons.category_outlined,
        color: Color(0xFF94A3B8),
      ),
    );

    if (predefined.value.isNotEmpty) {
      return predefined.icon;
    }

    final CustomCategory custom = _customCategoriesCache.firstWhere(
      (CustomCategory cc) => cc.name.toLowerCase() == categoryName.toLowerCase(),
      orElse: () => CustomCategory(
        uid: '',
        name: '',
        iconCodePoint: Icons.category_outlined.codePoint,
        updatedAt: DateTime.now(),
      ),
    );

    return IconData(
      custom.iconCodePoint,
      fontFamily: custom.iconFontFamily,
      fontPackage: custom.iconFontPackage,
    );
  }

  /// Checks if a category name already exists (predefined or active custom).
  Future<bool> categoryExists(String name) async {
    final bool isPredefined = subscriptionCategories.any(
      (SubscriptionCategoryOption opt) =>
          opt.label.toLowerCase() == name.toLowerCase() ||
          opt.value.toLowerCase() == name.toLowerCase(),
    );
    if (isPredefined) {
      return true;
    }

    final CustomCategory? existing = await _isar.customCategorys
        .filter()
        .nameEqualTo(name, caseSensitive: false)
        .isDeletedEqualTo(false)
        .findFirst();

    return existing != null;
  }

  /// Creates a new custom category.
  Future<void> createCustomCategory(String name, IconData icon) async {
    final CustomCategory customCat = CustomCategory(
      uid: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      iconCodePoint: icon.codePoint,
      iconFontFamily: icon.fontFamily,
      iconFontPackage: icon.fontPackage,
      updatedAt: DateTime.now(),
    );

    await _isar.writeTxn(() async {
      await _isar.customCategorys.put(customCat);
    });

    await reloadCache();
  }

  /// Soft-deletes a custom category.
  Future<void> deleteCustomCategory(int id) async {
    await _isar.writeTxn(() async {
      final CustomCategory? existing = await _isar.customCategorys.get(id);
      if (existing != null) {
        existing.isDeleted = true;
        existing.updatedAt = DateTime.now();
        await _isar.customCategorys.put(existing);
      }
    });

    await reloadCache();
  }
}
