import 'package:isar/isar.dart';

part 'custom_category.g.dart';

@collection
class CustomCategory {
  CustomCategory({
    this.id = Isar.autoIncrement,
    required this.uid,
    required this.name,
    required this.iconCodePoint,
    this.iconFontFamily,
    this.iconFontPackage,
    required this.updatedAt,
    this.isDeleted = false,
  });

  Id id;

  @Index(unique: true)
  String uid;

  @Index(caseSensitive: false)
  String name;

  int iconCodePoint;

  String? iconFontFamily;

  String? iconFontPackage;

  @Index()
  DateTime updatedAt;

  bool isDeleted;
}
