import 'package:storepool/data/store_enums.dart';

class CatalogCategoriesTableData {
  final String uuid;
  final String name;
  final String catalogType;
  final bool isSystem;

  const CatalogCategoriesTableData({
    required this.uuid,
    required this.name,
    required this.catalogType,
    required this.isSystem,
  });

  CatalogType get typeEnum {
    return CatalogType.values.firstWhere(
      (e) => e.name == catalogType,
      orElse: () => CatalogType.product,
    );
  }

  CatalogCategoriesTableData copyWith({
    String? uuid,
    String? name,
    String? catalogType,
    bool? isSystem,
  }) {
    return CatalogCategoriesTableData(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      catalogType: catalogType ?? this.catalogType,
      isSystem: isSystem ?? this.isSystem,
    );
  }
}